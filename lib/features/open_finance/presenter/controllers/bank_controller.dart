import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/core/mock_data.dart';
import 'package:kumbuz/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/open_finance/domain/usecases/connect_account_usecase.dart';
import 'package:kumbuz/features/open_finance/domain/usecases/fetch_transaction_usecase.dart';
import 'package:kumbuz/features/open_finance/domain/usecases/get_bank_accounts.dart';
import 'package:kumbuz/features/open_finance/domain/usecases/save_bank_account_usecase.dart';
import 'package:kumbuz/features/sateva/data/models/bank_account.dart';
import 'package:kumbuz/features/sateva/data/models/user.dart';
import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/domain/entities/bank_agreement.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/wallet_%20controller.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/add_expense_usecase.dart';
import 'package:kumbuz/shared/presentation/ui/widgets/notification_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/configs/config.dart';
import '../../../../core/configs/theme/colors.dart';
import '../../../../core/services/nordigen_service.dart';
import '../../../sateva/data/models/expense.dart';
import '../../domain/entity/bank_entity.dart';

class BankController extends ChangeNotifier {
  List<String> _accountsConnected = [];
  final String INSTITUTION_ID;
  NordigenClient _client;
  static List<WalletTransaction> bankTransactions = [];
  static Wallet? wallet;

  late Timer _timer;

  BankController(this._client, this.INSTITUTION_ID) {}

  List? get accountsConnected => _accountsConnected;

  Future<String?> generateToken() async {
    var token = await this._client.generateToken();
    return token['access'];
  }

  Future<List<Bank>?> getBanks(String country) async {
    await _client.generateToken();
    _client.institution!.client = _client;
    var response = await _client.institution!.getInstitutions(country: country);
    List<Bank> bankList = [];
    if (response != null) {
      response.forEach((element) {
        Bank bank = Bank(
            element['id'], element['name'], element['bic'], element['logo']);
        bankList.add(bank);
      });
    }

    return bankList;
  }

  Future<List<BankAccount>> getRegisterBanks(String userId) async {
    // return mockBanks;
    return await DI.get<GetBankAccounts>().handle(userId);

    return [];
  }

  Future<BankAgreement?> getAgreement(String agreementId) async {
    return null;
  }

  Future<NordigenAgreement?> createAgreement({int? maxHistoricalDays}) async {
    NordigenAgreement agreement = await _client.agreement!.createAgreement(
        institutionId: INSTITUTION_ID,
        maxHistoricalDays: maxHistoricalDays as int);
    return agreement;
  }

  Future<Map<String, String>?> getLinkAndIdBankConnection() async {
    return null;
  }

  Future<Map<dynamic, dynamic>?> connectAccount(String redirectUrl) async {
    try {
      var usecase = DI.get<ConnectAccountUsecase>();

      var data = await usecase.handler(redirectUrl);

      return data;
    } catch (error, st) {
      errorLog(error, st);
    }
  }

  Future<Map?> getAccountDetails(String accountId) async {
    try {
      var accountAPI = await _client.account(accountId: accountId);
      var accountMetada = await accountAPI.getDetails();
      return accountMetada;
    } catch (error) {
      debugPrint("Error: ${error}");
    }

    return null;
  }

  Future<Map?> getAccountBalances(String accountId) async {
    try {
      var accountAPI = await _client.account(accountId: accountId);
      var balances = await accountAPI.getBalances();
      return balances;
    } catch (error) {
      debugPrint("Error: ${error}");
    }

    return null;
  }

  Future<List<WalletTransaction>?> getAccountTransactions(String accountId,
      {String dateFrom = "", String dateTo = ""}) async {
    try {
      List<WalletTransaction> accountTransactions = [];

      var accountAPI = await _client.account(accountId: accountId);
      var transactions =
          await accountAPI.getTransactions(dateFrom: dateFrom, dateTo: dateTo);

      var listOfTransactions = (transactions['transactions']['booked'] as List);

      listOfTransactions.forEach((element) {
        var amount = double.parse(element['transactionAmount']['amount']);

        if (amount < 0) {
          WalletTransaction walletTransaction = WalletTransaction(
              Uuid().v4(),
              element['remittanceInformationUnstructured'],
              accountId,
              "",
              amount,
              "expense",
              element['valueDate'],
              "",
              DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
              DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));
          accountTransactions.add(walletTransaction);
        } else {
          WalletTransaction walletTransaction = WalletTransaction(
              Uuid().v4(),
              element['remittanceInformationUnstructured'],
              accountId,
              "",
              amount,
              "income",
              element['valueDate'],
              "",
              DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
              DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));
          accountTransactions.add(walletTransaction);
        }
      });

      return accountTransactions;
    } catch (error) {
      debugPrint("Error: ${error}");
    }

    return null;
  }

  //Save bank account in local storage

  Future<void> saveBankAccount(User? user, Bank bank,
      {String? accountId}) async {
    accountId ??= accountsConnected!.first;

    BankAccount novo = BankAccount(
        Uuid().v4(),
        user!.uuId,
        "General",
        bank.name,
        "PT000WE-OQASE",
        DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
        DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));

    wallet = Wallet(
        0,
        user.uuId,
        bank.name,
        100000,
        false,
        "${bank.logoUrl}",
        "bank",
        "",
        DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
        DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));
    wallet!.uuId = Uuid().v4();

    DI.get<SaveBankAccount>().handle(novo);

    _accountsConnected.add(bank.bic);

    //Todo os controladores não podem ser instanciados dentro de outros, para isso melhor criar usecases e repositories
    var walletController = WalletController();
    int? id;
    bankTransactions.clear();
    if (wallet!.id == 0) {
      id = await walletController.addWallet(wallet!);
      for (int i = 0; i < expenses.length; i++) {
        expenses[i].userId = user.uuId;
        expenses[i].walletId = id!;
        expenses[i].uuId = Uuid().v4();

        WalletTransaction transaction = WalletTransaction(
            Uuid().v4(),
            expenses[i].description,
            "${wallet!.uuId}",
            "${expenses[i].uuId}",
            expenses[i].amount,
            "expense",
            expenses[i].date,
            expenses[i].time,
            DateTime.now().toString(),
            DateTime.now().toString());

        bankTransactions.add(transaction);

        walletController.addExpense(walletId: id, expense: expenses[i]);
      }
      for (int i = 0; i < incomes.length; i++) {
        incomes[i].userId = user.uuId;
        incomes[i].walletId = id!;
        incomes[i].uuId = Uuid().v4();
        WalletTransaction transaction = WalletTransaction(
            Uuid().v4(),
            incomes[i].description,
            "${id}",
            "${incomes[i].uuId}",
            incomes[i].amount,
            "income",
            incomes[i].date,
            incomes[i].time,
            DateTime.now().toString(),
            DateTime.now().toString());
        bankTransactions.add(transaction);
        walletController.addIncome(walletId: id, income: incomes[i]);
      }
    }
  }

  Future<void> save() async {
    var walletController = WalletController();

    for (int i = 0; i < expenses.length; i++) {
      await walletController.addExpense(
          walletId: wallet!.id, expense: expenses[i]);
    }
    for (int i = 0; i < incomes.length; i++) {
      await walletController.addIncome(
          walletId: wallet!.id, income: incomes[i]);
    }
    wallet = null;
  }

  //Future<>

/*
  Future<void> saveBankAccount(User? user, Bank bank,
      {String? accountId}) async {
    accountId ??= accountsConnected!.first;
    print("Tentando adicionar conta...");
    var walletController = WalletController();

    var metadata = await getAccountDetails(accountId!);

    //debugPrint(jsonEncode(metadata));

    BankAccount novo = BankAccount(
        0,
        Uuid().v4(),
        user!.uuId,
        "General",
        bank.name,
        metadata!["iban"],
        DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
        DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));

    var balances = await getAccountBalances(accountsConnected!.first);
    debugPrint("BankController: ${jsonEncode(balances)}");
    var listOfBalances = (balances!['balances'] as List);
    if (listOfBalances != null) {
      var mapBalanceAmount = listOfBalances.first;

      debugPrint("BankController: ${jsonEncode(mapBalanceAmount)}");
      var amount = mapBalanceAmount['balanceAmount'];
      debugPrint(
          "BankController: Quantidade em carteira: ${jsonEncode(amount['amount'])}");

      Wallet newWallet = Wallet(
          0,
          user.uuId,
          bank.name,
          double.parse(amount['amount']),
          false,
          "${bank.logoUrl}",
          "bank",
          "",
          DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
          DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));
      newWallet.uuId = Uuid().v4();

      int? id = await walletController.addWallet(newWallet);

      List<WalletTransaction>? transactions =
          await getAccountTransactions(accountId);

      print("Tentando adicionar conta...");
      if (transactions != null) {
        for (int i = 0; i < transactions.length; i++) {
          if (transactions[i].type == "income") {
            await walletController.addIncome(
                walletId: id!,
                income: Income(
                    0,
                    user.uuId,
                    transactions[i].date,
                    "",
                    transactions[i].amount,
                    transactions[i].description,
                    "Outros",
                    id,
                    DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
                    DateTimeManipulation.getFormatDateForSQLite(
                        DateTime.now())));
          } else {
            await walletController.addExpense(
                walletId: id!,
                expense: Expense(
                    0,
                    user.uuId,
                    transactions[i].date,
                    "",
                    transactions[i].amount < 0
                        ? (transactions[i].amount * (-1))
                        : transactions[i].amount,
                    transactions[i].description,
                    "Outros",
                    id,
                    DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
                    DateTimeManipulation.getFormatDateForSQLite(
                        DateTime.now())));
          }
        }
      }
    }
  }
 */

  //Init listerner that verify new transactions

  void startTransactionListener() async {
    var shared = await SharedPreferences.getInstance();
    String lastSync = shared.getString("lastSync") ?? "2000-01-01";
    print("_startTransactionListener");

    var fetchTransaction = DI.get<FetchTransactionUsecase>();

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      print("Timer...");

      print("Contas conectadas....");
      print(_accountsConnected);
      var walletController = WalletController();
      for (String account in _accountsConnected) {
        var transactions = await fetchTransaction.handleMock(
            accountId: account,
            dateFrom: lastSync,
            dateTo:
                DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));

        // context.read<WalletController>().addIncome(walletId: 1, income: incomes[0]);

        var ex = Expense(
            1,
            Uuid().v4(),
            DateTimeManipulation.getDateOfPreviousMonth(DateTime.now()),
            TimeOfDay.now().toString(),
            700,
            "WORTEN - TERMINAL",
            "Outros",
            1,
            DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
            DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));

        ex.id = Random(234556443).nextInt(4050060);

        DI.get<AddExpenseUsecase>().handle(ex);
        WalletTransaction transaction = WalletTransaction(
            Uuid().v4(),
            ex.description,
            "222",
            "${ex.id}",
            ex.amount,
            "expense",
            ex.date,
            ex.time,
            DateTime.now().toString(),
            DateTime.now().toString());

        //debugPrint("This de Id of Income: $id");
        AppConfiguration.database!.walletTransactionDao.insertItem(transaction);

        NotificationAlert.show(
            "Nova transação ",
            "Recebeu novas transacções, visualize os detalhes no histórico",
            Icon(Icons.info_outline),
            PRIMARY_COLOR);
      }
    });
  }

// Future<void> _fetchNewTransactions() async {}

// Função que faz a requisição à API do banco para buscar transações
// Future<void> _fetchNewTransactions() async {
//   final response = await http.get(
//     Uri.parse('https://api.banco.com/transactions'), // Exemplo de URL da API
//     headers: {
//       'Authorization': 'Bearer SEU_TOKEN_DE_ACESSO',
//     },
//   );
//
//   if (response.statusCode == 200) {
//     List<dynamic> transactions = json.decode(response.body);
//     // Verifica se há novas transações
//     if (transactions.isNotEmpty &&
//         transactions[0]['id'] != _lastTransactionId) {
//       setState(() {
//         _transactions = transactions;
//         _lastTransactionId =
//             transactions[0]['id']; // Atualiza o ID da última transação
//       });
//       // Lógica para registrar ou notificar sobre novas transações
//       _registerNewTransaction(transactions[0]);
//     }
//   } else {
//     // Trate erros de requisição aqui
//     print('Erro ao obter transações: ${response.statusCode}');
//   }
// }

// Lógica para registrar ou exibir a nova transação
// void _registerNewTransaction(dynamic transaction) {
//   // Registrar no banco de dados local ou exibir ao usuário
//   print('Nova transação encontrada: $transaction');
// }
}

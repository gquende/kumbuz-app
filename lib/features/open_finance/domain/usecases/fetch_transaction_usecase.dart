import 'package:kumbuz/features/sateva/domain/entities/bank_transaction.dart';
import 'package:kumbuz/mocks/bank_transactions_mock.dart';
import 'package:uuid/uuid.dart';

import '../../../../utils/datetime_manipulation.dart';
import '../../../../core/services/nordigen_service.dart';

class FetchTransactionUsecase {
  final String INSTITUTION_ID;
  NordigenClient _client;

  FetchTransactionUsecase(this._client, this.INSTITUTION_ID);

  Future<List<BankTransaction>> handle(
      {required String accountId,
      required String dateFrom,
      required String dateTo}) async {
    var accountAPI = await _client.account(accountId: accountId);

    List<BankTransaction> accountTransactions = [];

    var transactions =
        await accountAPI.getTransactions(dateFrom: dateFrom, dateTo: dateTo);

    var listOfTransactions = (transactions['transactions']['booked'] ?? []);
    //var listOfTransactions = [];
    listOfTransactions.forEach((element) {
      var amount = double.parse(element['transactionAmount']['amount']);

      if (amount < 0) {
        BankTransaction transaction = BankTransaction(
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

        accountTransactions.add(transaction);
      } else {
        BankTransaction transaction = BankTransaction(
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

        accountTransactions.add(transaction);
      }
    });

    return [];
  }

  Future<List<BankTransaction>> handleMock(
      {required String accountId,
      required String dateFrom,
      required String dateTo}) async {
    var accountAPI = await _client.account(accountId: accountId);

    return bankTransactionsMock;
  }
}

// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/data/models/budget.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/data/models/income.dart';
import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/domain/entities/notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../../app.dart';
import '../../../../../core/utils/datetime_manipulation.dart';
import '../notification_usecases/insert_notification_usecase.dart';
import '../transactions_usecase/get_sum_transaction_by_type.dart';

class WalletController extends ChangeNotifier {
  Map<String, Wallet>? wallets;
  static var dateTimeSelected = DateTime.now();

  // WalletController(this.wallets);

  setData(DateTime date) {
    dateTimeSelected = date;

    notifyListeners();
  }

  Future<bool> removeWallet(Wallet wallet) async {
    var localStorage = await SharedPreferences.getInstance();
    if (wallets![wallet.id] != null) {
      wallets!.remove(wallet.id);
      localStorage.setString('wallets', jsonEncode(wallets));
      //Todo additional a parte da cloud
    }

    return false;
  }

  Future<bool> addIncome(
      {required int walletId, required Income income}) async {
    try {
      int id = await AppConfiguration.database!.incomeDao.insertItem(income);

      //Todo Trocar o id pelo ID do FireBase e trocar do Item da transacao pelo ID do FireBase

      WalletTransaction transaction = WalletTransaction(
          Uuid().v4(),
          income.description,
          "${walletId}",
          "${income.uuId}",
          income.amount,
          "income",
          income.date,
          income.time,
          DateTime.now().toString(),
          DateTime.now().toString());

      //debugPrint("This de Id of Income: $id");
      await AppConfiguration.database.walletTransactionDao
          .insertItem(transaction);

      //TODO Criar um mapa de wallet, de modo a descontar no wallet predefinido e carregar o mesmo
      App.wallet!.amount += income.amount;
      await AppConfiguration.database!.walletDao
          .updateItem(App.wallet as Wallet);

      notifyListeners();
      //Todo Add Firebase database;
      return true;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  // void _initialize() async {}

  Future<List<WalletTransaction>> getTransactions() async {
    try {
      // WalletTransactionDao walletTransactionDao;
      var data = await AppConfiguration.database.walletTransactionDao.getAll();

      print("GET TRANSACTIONS:: WALLET CONTROLLER");
      print(jsonEncode(data));

      return data;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  Future<List<WalletTransaction>> getTransactionsByWallet(String uuid) async {
    try {
      // WalletTransactionDao walletTransactionDao;
      print("UUID");
      print(uuid);

      return await AppConfiguration.database.walletTransactionDao
          .getWalletTransaction(uuid);
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  Future<double?> getTotalAmountIncomesOfMonth(String month) async {
    try {
      var value = await AppConfiguration.database!.incomeDao
          .getTotalAmountOfMonth(month);
      debugPrint("This is total amount of Month: $value");
      if (value != null) {
        return value;
      }
      return 0;
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<double?> getTotalAmountExpenseOfMonth(
      int walletId, String month) async {
    try {
      var value = await AppConfiguration.database!.expenseDao
          .getTotalAmountOfMonth(month);
      if (value != null) {
        return value;
      } else
        return 0;
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<double?> getBalanceOfMonth(int walletId, String month) async {
    try {
      return (await DI.get<GetSumAmountTransactionByType>().handle(
              type: "income",
              from: "1900-01-01",
              to: DateTimeManipulation.getDateOfTheLastDayOfMonth(
                  WalletController.dateTimeSelected))) -
          (await DI.get<GetSumAmountTransactionByType>().handle(
              type: "expense",
              from: "1900-01-01",
              to: DateTimeManipulation.getDateOfTheLastDayOfMonth(
                  WalletController.dateTimeSelected)));
    } catch (error) {}
    return null;
  }

  //Todo: Mover para o controllador Expense
  Future<bool> addExpense(
      {required int walletId,
      required Expense expense,
      BuildContext? context}) async {
    try {
      Budget? budget = await AppConfiguration.database!.budgetDao
          .getByCategory(expense.category);
      if (budget != null) {
        // print("Nao Sou Null");
        budget.amountConsume = (budget.amountConsume! + expense.amount);
        budget.percentComplete = (budget.amountConsume! / budget.amount) * 100;
        AppConfiguration.database!.budgetDao.updateItem(budget);

        if (context != null) {
          if (budget.percentComplete! > 80) {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      child: Text(
                          "Já consumiu ${budget.percentComplete}% do orçamento desta categoria"),
                    ),
                  );
                });
            var not = NotificationEntity.transaction(
                id: Uuid().v4(),
                title: "Seu orçamento atingiu ${budget.percentComplete}%",
                message:
                    "O seu orçamento da categoria '${expense.category}' está preste a exceder. Revise seus gastos antes que saia do controlo",
                dateTime: DateTime.now(),
                status: "noread");

            await context.read<InsertNotificationUsecase>().handle(not);
          }
        }
      }
      int id = await AppConfiguration.database.expenseDao.insertItem(expense);

      //Todo Trocar o id pelo ID do FireBase e trocar do Item da transacao pelo ID do FireBase

      WalletTransaction transaction = WalletTransaction(
          Uuid().v4(),
          expense.description,
          "${walletId}",
          "${expense.uuId}",
          expense.amount,
          "expense",
          expense.date,
          expense.time,
          DateTime.now().toString(),
          DateTime.now().toString());

      //Todo To Move this to a repository
      await AppConfiguration.database.walletTransactionDao
          .insertItem(transaction);

      //TODO Criar um mapa de wallet, de modo a descontar no wallet predefinido e carregar o mesmo

      App.wallet!.amount -= expense.amount;

      await AppConfiguration.database.walletDao
          .updateItem(App.wallet as Wallet);

      notifyListeners();

      //Todo Add Firebase database;
      return true;
    } catch (error) {
      print("Erro ao tentar inserir despesa...");
      debugPrint(error.toString());
      return false;
    }
  }

  Future<double?> getAmountOfWallet(int walletId) async {
    try {
      var value = await AppConfiguration.database!.walletDao
          .getAmountOfWallet(walletId);

      debugPrint("This is the value: $value of Amount");
      if (value != null) {
        return value;
      }
      return 0.0;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<int?> addWallet(Wallet wallet) async {
    try {
      return AppConfiguration.database!.walletDao.insertItem(wallet);
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  Future<int?> addWalletTransaction(WalletTransaction transaction) async {
    try {
      var id = await AppConfiguration.database!.walletTransactionDao
          .insertItem(transaction);
      debugPrint("Transaction n- $id\nWWUUID: ${transaction.walletId}");
      notifyListeners();
      return id;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  Future<List<WalletTransaction>?> getWalletTransaction(String uuid) async {
    try {
      var transactions = await AppConfiguration.database!.walletTransactionDao
          .getWalletTransaction(uuid);

      return transactions;
    } catch (error) {
      debugPrint("Error==> : ${error.toString()}");
    }
  }

  Future<double?> getSumOfAllWallet() async {
    try {
      var value =
          await AppConfiguration.database!.walletDao.getTotalAmountOfWallets();

      debugPrint("This is the value: $value of Amount");
      if (value != null) {
        return value;
      }
      return 0.0;
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

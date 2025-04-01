import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';

import '../../../../../core/di/dependecy_injection.dart';
import '../../../../../core/singletons/globals.dart';
import '../../entities/category.dart';
import '../../entities/transaction_entity.dart';
import '../transactions_usecase/update_transaction_usecase.dart';

class ExpenseController extends ChangeNotifier {
  var categories = <Category>[].obs;

  ExpenseController() {
    _getCategories();
  }

  _getCategories() async {
    //Todo criar usesase

    GlobalExpenseCategoryList = await AppConfiguration.database.categoryDao
            .getAllCategoriesByType("expense") ??
        [];
    // = GlobalExpenseCategoryList;
    print(categories.value);
  }

  Future<bool?> deleteExpense(Expense expense, {BuildContext? context}) async {
    try {
      var value =
          await AppConfiguration.database!.expenseDao.deleteItem(expense);
      if (value != null) {
        debugPrint("Expense deleted!");
        if (context != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Despesa eliminada!")));
        }
        notifyListeners();
        return true;
      } else {
        debugPrint("Unable to eliminate expense");
        if (context != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Despesa eliminada!")));
        }
        return false;
      }
    } catch (error) {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Despesa eliminada!\nErro: ${error.toString()}",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.pink,
        ));
      }
      debugPrint(error.toString());
    }
  }

  Future<bool?> updateExpense(Expense expense, TransactionEntity transaction,
      {BuildContext? context}) async {
    try {
      var value =
          await AppConfiguration.database.expenseDao.updateItem(expense);

      if (value != 0) {
        transaction.amount = expense.amount;
        transaction.time = expense.time;
        transaction.date = expense.date;
        transaction.description = expense.description;
        transaction.updateAt = expense.updateAt;

        print("DATA to update $transaction");

        await DI
            .get<UpdateTransactionUsecase>()
            .handle(transaction: transaction as WalletTransaction);

        // value = await AppConfiguration.database.walletTransactionDao
        //     .updateItem(transaction as WalletTransaction);

        debugPrint("Expense update!");
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Despesa actualizada!")));
        }
        notifyListeners();
        return true;
      } else {
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Falha ao tentar actualizar despesa")));
        }

        return false;
      }
    } catch (error, stackTrace) {
      errorLog(error, stackTrace);
      return false;
    }
  }

  Future<double?> getTotalAmountOfMonthWithCategory(
      String month, String category) async {
    try {
      var value = await AppConfiguration.database!.expenseDao
          .getTotalAmountOfMonthWithCategory(month, category);
      if (value != null) {
        return value;
      } else
        return 0;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<List<Expense>?> getAllForMonthOfCategory(
      String month, String category) async {
    try {
      var listOfExpense = await AppConfiguration.database.expenseDao
          .getAllForMonthOfCategory(month, category);
      return listOfExpense;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<List<Expense>?> getAllForDay(DateTime dateTime) async {
    try {
      String date = DateTimeManipulation.getFormatDateForSQLite(dateTime);
      var result = await AppConfiguration.database.expenseDao.getAllOfDay(date);
      if (result == null) return [];
      return result;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<Map<int, List<Expense>>?> getAllForMonth(DateTime dateTime) async {
    try {
      Map<int, List<Expense>> expenseMap = Map<int, List<Expense>>();
      for (int i = 1; i <= dateTime.day; i++) {
        String date = DateTimeManipulation.getFormatDateForSQLite(
            DateTime(dateTime.year, dateTime.month, i));
        List<Expense>? expensesOfDay =
            await AppConfiguration.database!.expenseDao.getAllOfDay(date);
        if (expensesOfDay.length > 0) {
          expenseMap[i] = expensesOfDay;
        }
      }
      return expenseMap;
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<List<Category>?> getSumByCategoryOfMonth(String date) async {
    try {
      //AppConfiguration.database.expenseDao.getTotalAmountOfMonthWithCategory(month, category);
      //List<Category>? list=[];
      var list = await AppConfiguration.database!.expenseDao
          .getSumByCategoryOfMonth(date);

      print("GETSUMBYCATEGAORYMONTH");
      // print(jsonEncode(list));

      return list;
    } catch (error) {
      debugPrint("Error: ${error.toString()}");
    }
    return null;
  }
}

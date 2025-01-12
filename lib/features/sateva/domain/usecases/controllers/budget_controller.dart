import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/services/mhadia_service.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/data/models/budget.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/expense.dart';
import 'expense_controlller.dart';

class BudgetController extends ChangeNotifier {
  Future<int?> createBudget(Budget budget, [BuildContext? context]) async {
    try {
      var value = await getBudgetByCategory(budget.category);
      print(value);
      //Verifica se ja existe um orcamento...
      if (value != null) {
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Já existe um orçamento com esta categoria...")));
        } else {
          debugPrint("Já existe um orçamento com esta categoria...");
        }
        return null;
      }

      double? totalExpensesForTheMonth = await ExpenseController()
          .getTotalAmountOfMonthWithCategory(
              "${formatDate(DateTime.now(), ['mm'])}", budget.category);
      if (totalExpensesForTheMonth != null && totalExpensesForTheMonth > 0) {
        budget.amountConsume = totalExpensesForTheMonth;
        budget.percentComplete = (budget.amountConsume! / budget.amount) * 100;
        var id = await AppConfiguration.database!.budgetDao.insertItem(budget);
        if (id != null) {
          notifyListeners();
          return id as int;
        }
      }

      var id = await AppConfiguration.database!.budgetDao.insertItem(budget);
      if (id != null) {
        notifyListeners();
        return id as int;
      }
      return null;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<Budget?> getBudgetByCategory(String category) async {
    try {
      var budget =
          await AppConfiguration.database!.budgetDao.getByCategory(category);
      if (budget != null) {
        return budget;
      }
      return null;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<Budget?> getBudgetByID(int id) async {
    try {
      var budget = await AppConfiguration.database!.budgetDao.getById(id);
      if (budget != null) {
        return budget;
      }
      return null;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<List<Budget>?> getBudgets() async {
    try {
      return await AppConfiguration.database!.budgetDao.getAll();
    } catch (error) {
      return null;
    }
  }

  Future<int?> deleteBudget(Budget budget, [BuildContext? context]) async {
    try {
      var value = await AppConfiguration.database!.budgetDao.deleteItem(budget);
      if (value != null) {
        notifyListeners();
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Orçamento Eliminado!"),
            backgroundColor: Colors.greenAccent,
          ));
        }
        return value;
      } else {
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text("Não foi possível eliminar o orçamento!"),
          backgroundColor: Colors.greenAccent,
        ));
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<int?> updateBudget(Budget budget, [BuildContext? context]) async {
    try {
      double? totalExpensesForTheMonth = await ExpenseController()
          .getTotalAmountOfMonthWithCategory(
              "${formatDate(DateTime.now(), ['mm'])}", budget.category);
      if (totalExpensesForTheMonth != null && totalExpensesForTheMonth > 0) {
        budget.amountConsume = totalExpensesForTheMonth;
        budget.percentComplete = (budget.amountConsume! / budget.amount) * 100;
        var value =
            await AppConfiguration.database!.budgetDao.updateItem(budget);
        if (value > 0) {
          notifyListeners();
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Orçamento actualizado!"),
              backgroundColor: Colors.greenAccent,
            ));
          }
          return value;
        } else if (value == null || value == 0) {
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Não foi possível actualizar o orçamento!"),
              backgroundColor: Colors.pinkAccent,
            ));
          }
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<List<Budget>?> getBudgetForAPeriod(String dateTime) async {
    try {
      var budgetList =
          AppConfiguration.database!.budgetDao.getForAPeriod(dateTime);
      if (budgetList != null) {
        return budgetList;
      }
      return [];
    } catch (error) {
      return [];
    }
  }

  Future<Budget?> predictBudgetByCategory(
      String name, String period, String category) async {
    try {
      Budget? budgetPredict;
      var service = MhadiaService(base_url: "http://192.168.137.219:5000");
      var expenseController = ExpenseController();
      List<Expense>? expenses = [];
      Map json = Map<String, String>();
      if (period == "mes") {
        expenses = await expenseController.getAllForMonthOfCategory(
            DateTimeManipulation.getYearAndMonthForSQliteFormat(DateTime.now()),
            category);
        if (expenses != null) {
          json["date"] = "amount";
          expenses.forEach((element) {
            if (json.containsKey("${element.date}")) {
              json["${element.date}"] =
                  "${double.parse(json["${element.date}"]) + element.amount}";
            } else {
              json["${element.date}"] = "${element.amount}";
            }
          });

          var data = await service.request(
              endpoint: "budget/predict", parameters: json, method: "POST");

          var yhat = (data as Map)["yhat"];
          int amount = double.parse("${(yhat as Map).values.first}").round();
          print("value predict: $amount");
          budgetPredict = Budget(
              0,
              Uuid().v4(),
              category,
              "predict",
              name,
              category,
              double.parse("${amount}"),
              0.0,
              DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
              DateTimeManipulation.getDateOfFowardMonth(DateTime.now()),
              0,
              DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
              DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));
          print("Budget Predict: ${budgetPredict.amount}");
        }
        //return null;
        return budgetPredict;
      }
    } catch (error) {
      print(error.toString());
    }
  }
}

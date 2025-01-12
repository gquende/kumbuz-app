import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/data/models/debt.dart';

import '../../../../core/db/database.dart';

class DebtsUsecases extends ChangeNotifier {
  AppDatabase _database;

  DebtsUsecases(this._database);

  Future<Debt?> getDebtByID(int id, {BuildContext? context}) async {
    return await _database.debtDao.getById(id);
  }

  Future<int?> insertDebt(Debt item, {BuildContext? context}) async {
    try {
      var id = await _database.debtDao.insertItem(item);

      if (id != null) {
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Dívida criada!"),
            backgroundColor: Colors.greenAccent,
          ));
        }
        notifyListeners();
        return id;
      }
    } catch (error, st) {
      errorLog(error, st);

      return null;
    }
  }

  Future<int> updateDebt(Debt item, {BuildContext? context}) async {
    var id = await _database.debtDao.updateItem(item);
    notifyListeners();
    return id;
  }

  Future<int> deleteDebt(Debt item, {BuildContext? context}) async {
    var id = await _database.debtDao.deleteItem(item);
    notifyListeners();
    return id;
  }

  Future<List<Debt>?> getDebtsNotDone() async {
    try {
      return await _database.debtDao.getAllDebtIsOrNotDone(isDone: false);
    } catch (error) {
      debugPrint("Error: ${error.toString()}");
    }
  }
}

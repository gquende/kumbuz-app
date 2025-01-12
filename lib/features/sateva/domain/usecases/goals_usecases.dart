import 'package:flutter/material.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/models/goals.dart';

class GoalsUsecases extends ChangeNotifier {
  AppDatabase _database;

  GoalsUsecases(this._database);

  Future<Goals?> getGoalByID(int id, {BuildContext? context}) async {
    return await _database.goalsDao.getById(id);
  }

  Future<int?> insertGoal(Goals item, {BuildContext? context}) async {
    try {
      var id = await _database.goalsDao.insertItem(item);

      if (id != null) {
        //d1ebugPrint("Good insertion");
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Objectivo criado!"),
            backgroundColor: Colors.greenAccent,
          ));
        }
        notifyListeners();
        return id;
      }
    } catch (error) {
      debugPrint("Erro... ${error.toString()}");

      return null;
    }
  }

  Future<int> updateGoal(Goals item, {BuildContext? context}) async {
    var id = await _database.goalsDao.updateItem(item);
    notifyListeners();
    return id;
  }

  Future<int> deleteGoal(Goals item, {BuildContext? context}) async {
    var id = await _database.goalsDao.deleteItem(item);
    notifyListeners();
    return id;
  }

  Future<List<Goals>?> getGoalsNotDone() async {
    try {
      //_database.goalsDao.

      //return list_goals_mocks;
      return await _database.goalsDao.getAllGoalsIsOrNotDone(false);
    } catch (error) {
      debugPrint("Error: ${error.toString()}");

      return [];
    }
  }
}

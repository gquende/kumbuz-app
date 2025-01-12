import 'package:kumbuz/core/db/database.dart';

class CheckBudgetProgressUsecasse {
  AppDatabase _database;

  CheckBudgetProgressUsecasse(this._database);

  Future<int> handle(String category) async {
    //return await _database.goalsDao.getById(id)
    // ;
    var result = await _database.budgetDao.getByCategory(category);

    if (result != null) {
      //Verifica se a quantidade consumida é maior que o definifo
      var percent = ((result.amountConsume ?? 0) / result.amount) * 100;
      return percent.floor();
    }

    return 0;
  }
}

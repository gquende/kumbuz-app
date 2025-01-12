import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/domain/repositories/expense/i_expense_repository.dart';

class ExpenseRepository implements IExpenseRepository<Expense> {
  late AppDatabase _appDatabase;
  String _tableName = "expenses";

  ExpenseRepository(AppDatabase appDb) : _appDatabase = appDb;

  @override
  Future<int> delete(Expense item) async {
    var result = await _appDatabase.database
        .delete(_tableName, where: "uuId='${item.uuId}'");
    return result;
  }

  @override
  Future<List<Expense>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<dynamic> insert(Expense item) async {
    var result = await _appDatabase.expenseDao.insertItem(item);
    return result;
  }

  @override
  Future<int> update(Expense item) async {
    try {
      var result = await _appDatabase.database
          .update(_tableName, item.toJson(), where: "uuId='${item.uuId}'");
      return result;
    } catch (error, tc) {
      errorLog(error, tc);

      return 0;
    }
  }

  @override
  Future<Expense?> getById({required String uuid}) async {
    try {
      var result = await _appDatabase.database
          .query(_tableName, where: "uuId='${uuid}'");
      return Expense.fromJson(result.first);
    } catch (error, stackTrace) {
      errorLog(error, stackTrace);
    }
    return null;
  }
}

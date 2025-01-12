import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_income_repository.dart';

import '../models/income.dart';

class IncomeRepository implements IIncomeRepository<Income> {
  late AppDatabase _appDatabase;
  String _tableName = "incomes";

  IncomeRepository(AppDatabase appDb) : _appDatabase = appDb;

  @override
  Future<int> delete(Income item) async {
    var result = await _appDatabase.database
        .delete(_tableName, where: "uuId='${item.uuId}'");
    return result;
  }

  @override
  Future<List<Income>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<dynamic> insert(Income item) async {
    var result = await _appDatabase.incomeDao.insertItem(item);
    return result;
  }

  @override
  Future<int> update(Income item) async {
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
  Future<Income?> getById({required String uuid}) async {
    try {
      var result = await _appDatabase.database
          .query(_tableName, where: "uuId='${uuid}'");
      return Income.fromJson(result.first);
    } catch (error, stackTrace) {
      errorLog(error, stackTrace);
    }
    return null;
  }
}

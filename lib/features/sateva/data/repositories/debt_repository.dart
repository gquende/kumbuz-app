import 'dart:developer';

import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/models/debt.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_debt_repository.dart';

class DebtRepository implements IDebtRepository<Debt> {
  late final AppDatabase _appDatabase;
  final String _tableName = "debts";

  DebtRepository(AppDatabase appDb) : _appDatabase = appDb;

  @override
  Future<int?> create(Debt data) async {
    try {
      var result =
          await _appDatabase.database.insert(_tableName, data.toJson());
      return result;
    } catch (error) {
      log("DebtRepository::Create:: ${error.toString()}");
    }
    return null;
  }

  @override
  Future<int> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Debt> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<int> update(Debt data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

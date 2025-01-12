import 'dart:developer';

import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/open_finance/domain/repository/i_bank_repository.dart';

import '../../../sateva/data/models/bank_account.dart';

class BankRepository extends IBankRepository<BankAccount> {
  late AppDatabase _appDatabase;
  final String _tableName = "bank_accounts";

  BankRepository(AppDatabase appDatabase) : _appDatabase = appDatabase;

  @override
  Future<int> delete(String uuid) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<BankAccount>> getAll(String userId) async {
    try {
      var data = await _appDatabase.database
          .rawQuery("SELECT * FROM $_tableName WHERE userId='$userId'");

      return data.map((toElement) {
        return BankAccount.fromJson(toElement);
      }).toList();
    } catch (error) {
      log("Repository: ${error.toString()}");
    }
    return [];
  }

  @override
  Future getBankWithBalance(String uuid) {
    // TODO: implement getBankWithBalance
    throw UnimplementedError();
  }

  @override
  Future insert(BankAccount item) async {
    try {
      var result =
          await _appDatabase.database.insert(_tableName, item.toJson());

      return result;
    } catch (error) {
      throw Exception("Não foi possível inserir a conta: ${error.toString()}");
    }
  }

  @override
  Future<int> update(BankAccount item) async {
    try {
      var result = await _appDatabase.database
          .update(_tableName, item.toJson(), where: "id='${item.uuid}'");

      return result;
    } catch (error) {
      throw Exception("Não foi possível inserir a conta: ${error.toString()}");
    }
  }

  @override
  Future<BankAccount?> getBankByName(String name) async {
    try {
      var data = await _appDatabase.database
          .rawQuery("SELECT * FROM $_tableName WHERE bankName='$name'");

      var banks = data.map((toElement) {
        return BankAccount.fromJson(toElement);
      }).toList();

      return banks.first;
    } catch (error) {
      log("Repository: ${error.toString()}");
    }
    return null;
  }
}

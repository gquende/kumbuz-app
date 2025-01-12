import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_transaction_repository.dart';


import '../../../../core/db/database.dart';
import '../../../../core/error/log/catch_error_log.dart';

class TransactionRepository extends ITransactionRepository<WalletTransaction> {
  late AppDatabase _db;
  final String _tableName = "transactions";

  TransactionRepository(AppDatabase db) {
    _db = db;
  }

  @override
  Future<List<WalletTransaction>> getAll(
      {String startDate = "", String endDate = ""}) async {
    List data = [];

    if (startDate.isEmpty && endDate.isEmpty) {
      data = await _db.database.rawQuery(
        "SELECT * FROM ${_tableName} ORDER BY date DESC",
      );
    } else {
      data = await _db.database.rawQuery(
          "SELECT * FROM ${_tableName} WHERE date>=?1 AND date<=?2  ORDER BY date DESC",
          [startDate, endDate]);
    }

    return data.map((row) {
      return WalletTransaction(
          row['uuId'] as String,
          row['description'] as String,
          row['walletId'] as String,
          row['itemId'] as String,
          row['amount'] as double,
          row['type'] as String,
          row['date'] as String,
          row['time'] as String,
          row['createAt'] as String,
          row['updateAt'] as String);
    }).toList();
  }

  @override
  Future<List<WalletTransaction>> getByDescription(
      {required String description}) async {
    List data = [];

    if (description.isNotEmpty) {
      data = await _db.database.rawQuery(
          "SELECT * FROM $_tableName where description LIKE '%$description%' ORDER BY date DESC");
    }

    return data.map((row) {
      return WalletTransaction(
          row['uuId'] as String,
          row['description'] as String,
          row['walletId'] as String,
          row['itemId'] as String,
          row['amount'] as double,
          row['type'] as String,
          row['date'] as String,
          row['time'] as String,
          row['createAt'] as String,
          row['updateAt'] as String);
    }).toList();
  }

  @override
  Future<List<WalletTransaction>> getAllByType(
      {String type = "", String startDate = "", String endDate = ""}) async {
    List data = [];

    if (startDate.isEmpty && endDate.isEmpty) {
      data = await _db.database.rawQuery(
        "SELECT * FROM $_tableName WHERE type='$type' ORDER BY date DESC",
      );
    } else {
      data = await _db.database.rawQuery(
          "SELECT * FROM ${_tableName} WHERE date>=?1 AND date<=?2 AND type='$type' ORDER BY date DESC",
          [startDate, endDate]);
    }

    return data.map((row) {
      return WalletTransaction(
          row['uuId'] as String,
          row['description'] as String,
          row['walletId'] as String,
          row['itemId'] as String,
          row['amount'] as double,
          row['type'] as String,
          row['date'] as String,
          row['time'] as String,
          row['createAt'] as String,
          row['updateAt'] as String);
    }).toList();
  }

  @override
  Future<double?> getSumByType(
      {String type = "", String startDate = "", String endDate = ""}) async {
    var total = 0.0;

    try {
      List data = [];
      if (startDate.isEmpty && endDate.isEmpty) {
        data = await _db.database.rawQuery(
          "SELECT SUM(amount) as total FROM $_tableName WHERE type='$type' ORDER BY date DESC",
        );
      } else {
        data = await _db.database.rawQuery(
            "SELECT SUM(amount) as total FROM ${_tableName} WHERE date>=?1 AND date<=?2 AND type='$type' ORDER BY date DESC",
            [startDate, endDate]);
      }

      for (var res in data) {
        total += res['total'] ?? 0;
      }
    } catch (error) {
      debugPrint("TRANSACTION REPO:: GET_SUM_BY_TYP::${error.toString()}");
    }

    return total;
  }

  @override
  Future<List<WalletTransaction>> getAllByTypeAndItemID(
      {required String type,
      required String itemId,
      String startDate = "",
      String endDate = ""}) async {
    List data = [];

    if (startDate.isEmpty && endDate.isEmpty) {
      data = await _db.database.rawQuery(
        "SELECT * FROM $_tableName WHERE type='$type' AND itemId='$itemId' ORDER BY date DESC",
      );
    } else {
      data = await _db.database.rawQuery(
          "SELECT * FROM ${_tableName} WHERE date>=?1 AND date<=?2 AND type='$type' AND AND itemId='$itemId' ORDER BY date DESC",
          [startDate, endDate]);
    }

    return data.map((row) {
      return WalletTransaction(
          row['uuId'] as String,
          row['description'] as String,
          row['walletId'] as String,
          row['itemId'] as String,
          row['amount'] as double,
          row['type'] as String,
          row['date'] as String,
          row['time'] as String,
          row['createAt'] as String,
          row['updateAt'] as String);
    }).toList();
  }

  @override
  Future<int> delete({required String id}) async {
    try {
      var data = await _db.database.delete(_tableName, where: "uuid='$id'");
      return data;
    } catch (error) {
      log("TransactionRepository:: Delete ${error.toString()}");
    }
    return 0;
  }

  @override
  Future<int> insert({required WalletTransaction t}) async {
    try {
      var data = await _db.walletTransactionDao.insertItem(t);

      throw Exception("Tesntao o erro");
      return data;
    } catch (error, stackTrace) {
      errorLog(error, stackTrace);
      return 0;
    }
  }

  @override
  Future update(WalletTransaction t) async {
    try {
      var data = await _db.database.rawQuery(
          "UPDATE $_tableName SET description = ?1, walletId = ?2, amount = ?3, type = ?4, date = ?5, time = ?6 ,createAt=?7, updateAt=?8 WHERE uuid = ?9;",
          [
            t.description,
            t.walletId,
            t.amount,
            t.type,
            t.date,
            t.time,
            t.createAt,
            t.updateAt,
            t.uuid
          ]);

      return data.length > 0;
    } catch (error, stackTrace) {
      errorLog(error, stackTrace);
    }
  }
}

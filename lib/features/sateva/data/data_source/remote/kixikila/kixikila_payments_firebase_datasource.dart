import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';

class KixikilaPaymentsRemoteDataSource {
  static final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<bool> insert(Map<String, dynamic> payment) async {
    try {
      print(payment);

      await database
          .ref("kixikilas")
          .child(payment["kixikilaId"])
          .child("payments")
          .child(payment["id"])
          .set(payment);

      return true;
    } catch (error, st) {
      errorLog(error, st);
      return false;
    }
  }

  Future<dynamic> getPayments(String kixikilaId) async {
    List<Map> payments = [];
    try {
      var data = await database
          .ref("kixikilas")
          .child(kixikilaId)
          .child("payments")
          .get();

      return data.value;
    } catch (error) {
      log("KixikilaPaymentsRemoteDataSource:: GetPayments:: ${error.toString()}");
      return [];
    }
  }
}

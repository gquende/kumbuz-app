import 'dart:developer';

import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_payment.dart';

import '../../../../../core/error/log/catch_error_log.dart';
import '../../../domain/repositories/kixikila/i_kixikila_payment_repository.dart';
import '../../data_source/remote/kixikila/kixikila_payments_firebase_datasource.dart';

class KixikilaPaymentRepository implements IKixikilaPaymentRepository {
  late KixikilaPaymentsRemoteDataSource _remoteDataSource;

  KixikilaPaymentRepository(
      {required KixikilaPaymentsRemoteDataSource remoteDataSource}) {
    _remoteDataSource = remoteDataSource;
  }

  @override
  Future<int> deleteItem(KixikilaPayment item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future getAllByKixikila(String kixikilaId) async {
    try {
      var data = await _remoteDataSource.getPayments(kixikilaId);

      List<KixikilaPayment> payments = [];

      (data as Map).forEach((k, v) {
        payments.add(KixikilaPayment.fromJson(v));
      });

      print("Repo Kixi");
      print(payments);

      return payments;
    } catch (error) {
      log("KixikilaPaymentsRepo:: GetAllByKixikila:: ${error.toString()}");
    }
  }

  @override
  Future<KixikilaPayment?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<int> insertItem(KixikilaPayment item) async {
    try {
      return await _remoteDataSource.insert(item.toJson()) ? 1 : 0;
    } catch (error, st) {
      errorLog(error, st);
      return 0;
    }
  }

  @override
  Future<int> updateItem(KixikilaPayment item) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }
}

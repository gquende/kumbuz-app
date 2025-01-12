import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_payment.dart';

import '../../../repositories/kixikila/i_kixikila_payment_repository.dart';

class KixikilaPaymentGetAllUsecase {
  late IKixikilaPaymentRepository _repository;

  KixikilaPaymentGetAllUsecase(
      {required IKixikilaPaymentRepository repository}) {
    _repository = repository;
  }

  Future<List<KixikilaPayment>?> handle(String kixikilaId) async {
    try {
      var data = await _repository.getAllByKixikila(kixikilaId) ?? [];

      print("Payments:: ");
      print(data);

      return data;
    } catch (error, st) {
      errorLog(error, st);
    }
  }
}

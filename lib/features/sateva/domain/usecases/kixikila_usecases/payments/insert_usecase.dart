import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_payment.dart';

import '../../../repositories/kixikila/i_kixikila_payment_repository.dart';

class KixikilaPaymentInsertUsecase {
  late IKixikilaPaymentRepository _repository;

  KixikilaPaymentInsertUsecase(
      {required IKixikilaPaymentRepository repository}) {
    _repository = repository;
  }

  Future<int> handle(KixikilaPayment payment) async {
    return await _repository.insertItem(payment);
  }
}

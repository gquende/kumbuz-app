import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_payment.dart';

abstract interface class IKixikilaPaymentRepository<T extends KixikilaPayment> {
  Future<int> insertItem(T item);

  Future<int> updateItem(T item);

  Future<int> deleteItem(T item);

  Future<T?> getById(int id);

  Future<dynamic> getAllByKixikila(String kixikilaId);
}

import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';

abstract interface class IKixikilaGuestRepository<T extends KixikilaGuest> {
  Future<int> insertItem(List<T> item);

  Future<int> updateItem(T item);

  Future<int> deleteItem(T item);

  Future<T?> getById(String id);

  Future<List<T>> getAllByKixikila(String kixikilaId);
}

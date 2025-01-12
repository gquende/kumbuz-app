import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila.dart';

abstract interface class IKixikilaRepository<T extends Kixikila> {
  Future<int> insertItem(T item);
  Future<int> insertKixikilaInTheGuest(
      {required String guestId, required String kixikilaId});

  Future<int> updateItem(T item);

  Future<int> deleteItem(T item);

  Future<T?> getById(String id);

  Future<List<Kixikila>> getAll(String userId);
}

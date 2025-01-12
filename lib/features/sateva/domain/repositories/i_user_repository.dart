import '../entities/user_entity.dart';

abstract interface class IUserRepository<T extends UserEntity> {
  Future<dynamic?> getById(String id);
  Future<T?> create(T data);
  Future<int> update(T data);
  Future<int> delete(String id);
}

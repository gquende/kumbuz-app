import '../../data/models/debt.dart';

abstract interface class IDebtRepository<T extends Debt> {
  Future<T> getById(String id);
  Future<int?> create(T data);
  Future<int> update(T data);
  Future<int> delete(String id);
}

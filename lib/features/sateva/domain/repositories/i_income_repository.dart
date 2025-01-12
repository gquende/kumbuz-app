import '../../data/models/income.dart';

abstract interface class IIncomeRepository<T extends Income> {
  Future<dynamic> insert(T item);
  Future<int> delete(T item);
  Future<int> update(T item);
  Future<List<T>> getAll();
  Future<T?> getById({required String uuid});
}

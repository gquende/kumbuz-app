import 'package:kumbuz/features/sateva/data/models/expense.dart';

abstract interface class IExpenseRepository<T extends Expense> {
  Future<dynamic> insert(T item);

  Future<int> delete(T item);

  Future<int> update(T item);

  Future<List<T>> getAll();

  Future<T?> getById({required String uuid});
}

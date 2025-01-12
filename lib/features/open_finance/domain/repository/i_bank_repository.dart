import '../../../sateva/data/models/bank_account.dart';

abstract class IBankRepository<T extends BankAccount> {
  Future<dynamic> insert(T item);
  Future<dynamic> getBankWithBalance(String uuid);
  Future<T?> getBankByName(String name);
  Future<int> delete(String uuid);
  Future<int> update(T item);
  Future<List<T>> getAll(String userId);
}

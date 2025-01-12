import 'package:kumbuz/features/sateva/data/models/wallet.dart';

abstract class IWalletRepository<T extends Wallet> {
  Future<dynamic> getById(String id);
  Future<List<T>> getByType(String type);
  Future<T?> create(T data);
  Future<int> update(T data);
  Future<int> delete(String id);
}

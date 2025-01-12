
import 'package:kumbuz/features/sateva/data/models/wallet.dart';

import '../../../../core/db/database.dart';
import '../../domain/repositories/i_wallet_repository.dart';

class WalletRepository extends IWalletRepository {
  late AppDatabase _db;
  final String _tableName = "wallets";

  WalletRepository(AppDatabase db) {
    _db = db;
  }

  @override
  Future<Wallet?> create(Wallet data) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<int> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Wallet>> getByType(String type) async {
    try {
      var data = await _db.database
          .rawQuery("SELECT * FROM $_tableName WHERE type='$type'");

      print("DADOS DE WALLET");
      print(data);
      var list = data.map((toElement) => Wallet.fromJson(toElement)).toList();
      print("LISTAAAA");
      print(list);

      return list;
    } catch (error) {
      // log("WALLET_REPO_ERROR:: ${error.toString()}" as num);

      print(error.toString());
    }
    return <Wallet>[];
  }

  @override
  Future<int> update(Wallet data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

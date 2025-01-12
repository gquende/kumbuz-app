import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';

import 'package:kumbuz/features/sateva/domain/repositories/repository_dao_interface.dart';

@dao
abstract class WalletTransactionDao
    extends IRepositoryDaoInterface<WalletTransaction> {
  @Query('Select * from transactions where id = :id')
  Future<WalletTransaction?> getById(int id);

  @Query('SELECT * FROM transactions ORDER BY date DESC')
  Future<List<WalletTransaction>> getAll();

  @Query('SELECT * FROM transactions where uuId = :uuid')
  Future<List<WalletTransaction>> getWalletTransaction(String uuid);
}
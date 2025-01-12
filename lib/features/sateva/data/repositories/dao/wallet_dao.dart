import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:kumbuz/features/sateva/domain/repositories/repository_dao_interface.dart';

@dao
abstract class WalletDao extends IRepositoryDaoInterface<Wallet> {
  @Query('Select * from wallets where id = :id')
  Future<Wallet?> getById(int id);

  @Query('Select * from wallets')
  Future<List<Wallet>> getAll();

  @Query("Select Sum(amount) as valor from wallets")
  Future<double?> getTotalAmountOfWallets();

  //TODO no final modificar as query no ficheiro database.g
  @Query("Select amount from wallets where id= :id")
  Future<double?> getAmountOfWallet(int id);
}

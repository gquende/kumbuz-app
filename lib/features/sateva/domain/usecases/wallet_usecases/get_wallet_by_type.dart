import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_wallet_repository.dart';

class GetWalletByType {
  IWalletRepository _repo;
  GetWalletByType(IWalletRepository repo) : _repo = repo;

  Future<List<Wallet>> handle(String type) async {
    return await _repo.getByType(type);
  }
}

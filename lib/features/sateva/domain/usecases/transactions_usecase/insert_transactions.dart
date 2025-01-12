import 'package:kumbuz/features/sateva/domain/repositories/i_transaction_repository.dart';

class InsertTransactionUsecase {
  ITransactionRepository _repo;

  InsertTransactionUsecase(ITransactionRepository repo) : _repo = repo;

  Future<int> handle({required String id}) async {
    var data = await _repo.delete(id: id);
    return data;
  }
}

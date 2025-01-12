import 'package:kumbuz/features/sateva/domain/repositories/i_transaction_repository.dart';

class DeleteTransactionUsecase {
  ITransactionRepository _repo;

  DeleteTransactionUsecase(ITransactionRepository repo) : _repo = repo;

  Future<int> handle({required String id}) async {
    var data = await _repo.delete(id: id);
    return data;
  }
}

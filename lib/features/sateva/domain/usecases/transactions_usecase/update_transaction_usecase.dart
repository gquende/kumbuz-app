import 'package:kumbuz/features/sateva/domain/entities/transaction_entity.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_transaction_repository.dart';

class UpdateTransactionUsecase {
  ITransactionRepository _repo;

  UpdateTransactionUsecase(ITransactionRepository repo) : _repo = repo;

  Future<int> handle({required TransactionEntity transaction}) async {
    var data = await _repo.update(transaction) ? 1 : 0;
    return data;
  }
}

import 'package:kumbuz/features/sateva/domain/repositories/i_transaction_repository.dart';

class GetSumAmountTransactionByType {
  ITransactionRepository _repo;
  GetSumAmountTransactionByType(ITransactionRepository repo) : _repo = repo;
  Future<double> handle(
      {required String type, String from = "", String to = ""}) async {
    return await _repo.getSumByType(type: type, startDate: from, endDate: to) ??
        0;
  }
}

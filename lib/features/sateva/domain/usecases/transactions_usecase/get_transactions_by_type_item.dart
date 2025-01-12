import 'package:kumbuz/features/sateva/domain/entities/transaction_entity.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_transaction_repository.dart';

class GetTransactionsByTypeItem {
  ITransactionRepository _repo;
  GetTransactionsByTypeItem(ITransactionRepository repo) : _repo = repo;
  Future<List<TransactionEntity>> handle(
      {required String type,
      required String itemId,
      String from = "",
      String to = ""}) async {
    var data = await _repo.getAllByTypeAndItemID(
        type: type, itemId: itemId, startDate: from, endDate: to);

    print("GetTransactionsByTypeItem:: DATA");
    print(data);

    return data;
  }
}

import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';

import '../../repositories/expense/i_expense_repository.dart';

class GetExpenseByIDUsecase {
  late IExpenseRepository _repository;

  GetExpenseByIDUsecase(IExpenseRepository repo) : _repository = repo;

  Future<Expense?> handle({required String uuid}) async {
    try {
      var value = await _repository.getById(uuid: uuid);
      return value;
    } catch (error, st) {
      errorLog(error, st);
    }
    return null;
  }
}

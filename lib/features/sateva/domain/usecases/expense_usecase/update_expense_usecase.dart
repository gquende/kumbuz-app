import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';

import '../../repositories/expense/i_expense_repository.dart';

class UpdateExpenseUsecase {
  late IExpenseRepository _repository;

  UpdateExpenseUsecase(IExpenseRepository repo) : _repository = repo;

  Future<int> handle(Expense expense) async {
    try {
      var value = await _repository.update(expense);
      return value;
    } catch (error, st) {
      errorLog(error, st);
    }
    return 0;
  }
}

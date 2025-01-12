import 'package:flutter/material.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';

import '../../repositories/expense/i_expense_repository.dart';

class AddExpenseUsecase extends ChangeNotifier {
  late IExpenseRepository _repository;

  AddExpenseUsecase(IExpenseRepository repo) : _repository = repo;

  Future<int> handle(Expense expense) async {
    try {
      var value = await _repository.insert(expense);

      notifyListeners();
    } catch (error, st) {
      errorLog(error, st);
    }
    return 0;
  }
}

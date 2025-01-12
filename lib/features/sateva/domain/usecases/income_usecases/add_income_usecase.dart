import 'package:flutter/material.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';

import '../../../data/models/income.dart';
import '../../repositories/i_income_repository.dart';

class AddIncomeUsecase extends ChangeNotifier {
  late IIncomeRepository _repository;

  AddIncomeUsecase(IIncomeRepository repo) : _repository = repo;

  Future<int> handle(Income item) async {
    try {
      var value = await _repository.insert(item);

      notifyListeners();
    } catch (error, st) {
      errorLog(error, st);
    }
    return 0;
  }
}

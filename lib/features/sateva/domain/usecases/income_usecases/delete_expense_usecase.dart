import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/data/models/income.dart';

import '../../repositories/i_income_repository.dart';

class DeleteIncomeUsecase {
  late IIncomeRepository _repository;

  DeleteIncomeUsecase(IIncomeRepository repo) : _repository = repo;

  Future<int> handle(Income item) async {
    try {
      var value = await _repository.delete(item);
      return value;
    } catch (error, st) {
      errorLog(error, st);
    }
    return 0;
  }
}

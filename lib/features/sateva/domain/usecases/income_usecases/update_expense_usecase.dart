import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/data/models/income.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_income_repository.dart';

class UpdateIncomeUsecase {
  late IIncomeRepository _repository;

  UpdateIncomeUsecase(IIncomeRepository repo) : _repository = repo;

  Future<int> handle(Income income) async {
    try {
      var value = await _repository.update(income);
      return value;
    } catch (error, st) {
      errorLog(error, st);
    }
    return 0;
  }
}

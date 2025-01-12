import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_income_repository.dart';

import '../../../data/models/income.dart';

class GetIncomeByIDUsecase {
  late IIncomeRepository _repository;

  GetIncomeByIDUsecase(IIncomeRepository repo) : _repository = repo;

  Future<Income?> handle({required String uuid}) async {
    try {
      var value = await _repository.getById(uuid: uuid);
      return value;
    } catch (error, st) {
      errorLog(error, st);
    }
    return null;
  }
}

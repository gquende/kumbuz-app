import 'package:kumbuz/core/error/log/catch_error_log.dart';

import '../../../data/models/debt.dart';
import '../../repositories/i_debt_repository.dart';

class CreateDebtUsecase {
  late final IDebtRepository _repository;

  CreateDebtUsecase(IDebtRepository repo) : _repository = repo;

  Future<int?> handle(Debt debt) async {
    try {
      var value = await _repository.create(debt);
      return value;
    } catch (error, st) {
      errorLog(error, st);
    }
    return 0;
  }
}

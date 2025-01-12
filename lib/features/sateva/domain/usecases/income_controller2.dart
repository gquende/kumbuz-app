import 'package:kumbuz/features/sateva/domain/entities/income2.dart';
import 'package:kumbuz/features/sateva/domain/repositories/income_repository.dart';

class IncomeController2 {
  final IncomeRepository incomeRepository;

  IncomeController2({required this.incomeRepository});

  Future<Income2> getIncomeById(int id) async {
    return await incomeRepository.getIncomeById(id);
  }
}
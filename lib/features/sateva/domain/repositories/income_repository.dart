import 'package:kumbuz/features/sateva/domain/entities/income2.dart';

abstract class IncomeRepository {
  Future<Income2> getIncomeById(int id);
}

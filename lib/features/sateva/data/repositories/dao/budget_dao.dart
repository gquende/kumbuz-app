import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/budget.dart';

import 'package:kumbuz/features/sateva/domain/repositories/repository_dao_interface.dart';

@dao
abstract class BudgetDao extends IRepositoryDaoInterface<Budget> {

  @Query('Select * from budgets where id = :id')
  Future<Budget?> getById(int id);

  @Query('Select * from budgets where uuid = :uuid')
  Future<Budget?> getByUUID(String uuid);

  @Query('SELECT * FROM budgets ORDER BY createAt DESC')
  Future<List<Budget>> getAll();

  @Query('Select * from budgets where category = :category')
  Future<Budget?> getByCategory(String category);

  @Query('Select * from budgets where initialDate = :datetime')
  Future<List<Budget>> getForAPeriod(String datetime);
}
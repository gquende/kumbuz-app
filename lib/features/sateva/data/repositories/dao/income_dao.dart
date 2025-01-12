// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/income.dart';

import 'package:kumbuz/features/sateva/domain/repositories/repository_dao_interface.dart';
// import 'package:kumbuz/repository/repository_dao_interface.dart';

@dao
abstract class IncomeDao extends IRepositoryDaoInterface<Income> {
  @Query('Select * from incomes where id2 = :id')
  Future<Income?> getById(int id);

  @Query('Select * from incomes')
  Future<List<Income>> getAll();

  @Query("Select Sum(amount) as valor from incomes")
  Future<double?> getTotalIncomes();

  //TODO no final modificar as query no ficheiro database.g
  @Query(
      "Select sum(amount) as total from incomes where STRFTIME('%Y-%m', date)= :month")
  Future<double?> getTotalAmountOfMonth(String month);
}

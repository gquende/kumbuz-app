import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';

import 'package:kumbuz/features/sateva/domain/repositories/repository_dao_interface.dart';

import '../../../domain/entities/category.dart';

@dao
abstract class ExpenseDao extends IRepositoryDaoInterface<Expense> {
  @Query('Select * from expenses where id = :id')
  Future<Expense?> getById(int id);

  @Query('Select * from expenses')
  Future<List<Expense>> getAll();

  //Todo: Mudar o nome desta funcao
  @Query("Select Sum(amount) as valor from expenses")
  Future<double?> getTotalIncomes();

  //TODO no final modificar as query no ficheiro database.g
  @Query(
      "Select sum(amount) as total from expenses where STRFTIME('%Y-%m', date)= :date")
  Future<double?> getTotalAmountOfMonth(String date);

  @Query(
      "Select sum(amount) as total from expenses where STRFTIME('%m', date)= :month and category= :category")
  Future<double?> getTotalAmountOfMonthWithCategory(
      String month, String category);

  @Query(
      "Select * from expenses where STRFTIME('%Y-%m', date)= :date and category= :category")
  Future<List<Expense>> getAllForMonthOfCategory(String date, String category);

  @Query("SELECT * FROM expenses WHERE STRFTIME('%Y-%m', date)= :date")
  Future<List<Expense>> getAllForMonth(String date);

  @Query("SELECT * FROM expenses WHERE date= :date ORDER BY createAt DESC")
  Future<List<Expense>> getAllOfDay(String date);

  @Query(
      "SELECT sum(amount) as total,categories.uuid, categories.id,categories.userId, name, color, iconUrl from expenses inner join categories on expenses.category=categories.name WHERE STRFTIME(\'%Y-%m\',date)= :date GROUP by category")
  Future<List<Category>?> getSumByCategoryOfMonth(String date);
}

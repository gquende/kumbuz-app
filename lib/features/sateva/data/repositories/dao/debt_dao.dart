import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/debt.dart';
import 'package:kumbuz/features/sateva/domain/repositories/repository_dao_interface.dart';

@dao
abstract class DebtDao extends IRepositoryDaoInterface<Debt> {
  @Query("Select * from debts where id= :id")
  Future<Debt?> getById(int id);

  @Query("Select * from debts")
  Future<List<Debt>> getAllGoals();

  @Query("Select * from debts where isDone= :isDone")
  Future<List<Debt>> getAllDebtIsOrNotDone({required bool isDone});

  @Query("Select * from debts where date=:date")
  Future<List<Debt>> getAllGoalsOfDate(String date);
}

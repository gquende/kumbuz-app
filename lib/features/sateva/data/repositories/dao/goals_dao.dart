import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/goals.dart';
import 'package:kumbuz/features/sateva/domain/repositories/repository_dao_interface.dart';

@dao
abstract class GoalsDAO extends IRepositoryDaoInterface<Goals> {
  @Query("Select * from goals where id= :id")
  Future<Goals?> getById(int id);

  @Query("Select * from goals")
  Future<List<Goals>> getAllGoals();

  @Query("Select * from goals where isDone= :done")
  Future<List<Goals>> getAllGoalsIsOrNotDone(bool done);

  @Query("Select * from goals where date=:date")
  Future<List<Goals>> getAllGoalsOfDate(String date);
}
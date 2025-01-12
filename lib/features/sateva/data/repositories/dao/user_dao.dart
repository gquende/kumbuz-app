import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/user.dart';

import 'package:kumbuz/features/sateva/domain/repositories/repository_dao_interface.dart';

@dao
abstract class UserDao extends IRepositoryDaoInterface<User> {
  @Query(
      'select * from users where  username= :username and password= :password')
  Future<User?> getByUsernameAndPassword(String username, String password);
}
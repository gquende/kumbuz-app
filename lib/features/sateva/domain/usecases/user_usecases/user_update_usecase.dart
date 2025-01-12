import 'package:kumbuz/features/sateva/domain/entities/user_entity.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_user_repository.dart';

class UserUpdateUsecase {
  late IUserRepository _repository;

  UserUpdateUsecase({required IUserRepository repository}) {
    _repository = repository;
  }

  Future<int> handle(UserEntity user) async {
    return await _repository.update(user);
  }
}

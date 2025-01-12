import 'package:kumbuz/features/sateva/domain/repositories/i_user_repository.dart';

class UserLogoutUsecase {
  late IUserRepository _repository;

  UserLogoutUsecase({required IUserRepository repository}) {
    _repository = repository;
  }

  Future<int?> handle(String uuid) async {
    var data = await _repository.delete(uuid);
    return data;
  }
}

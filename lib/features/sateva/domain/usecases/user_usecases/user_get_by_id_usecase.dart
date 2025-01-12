import 'package:kumbuz/features/sateva/domain/repositories/i_user_repository.dart';

class UserGetByIdUsecase {
  late IUserRepository _repository;

  UserGetByIdUsecase({required IUserRepository repository}) {
    _repository = repository;
  }

  Future<Map<dynamic, dynamic>?> handle(String id) async {
    var data = await _repository.getById(id);

    return data;
  }
}

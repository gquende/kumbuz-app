import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kumbuz/features/sateva/domain/entities/user_entity.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_user_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class UserCreateUsecase {
  late IUserRepository _repository;

  UserCreateUsecase({required IUserRepository repository}) {
    _repository = repository;
  }

  Future<UserEntity?> handle(UserEntity user) async {
    //Get Device Nofitification ID
    OneSignal.initialize(dotenv.get("ONESIGNAL_APP_ID"));
    var onesignalId = await OneSignal.User.getOnesignalId();
    user.notificationDeviceId = onesignalId;
    await OneSignal.User.addAlias("user_app", user.username);

    var data = await _repository.create(user);
    return data;
  }
}

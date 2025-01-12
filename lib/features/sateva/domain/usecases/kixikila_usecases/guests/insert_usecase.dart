import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';

import '../../../repositories/kixikila/i_kixikila_user_repository.dart';

class KixikilaGuestInsertUsecase {
  late IKixikilaGuestRepository _repository;

  KixikilaGuestInsertUsecase({required IKixikilaGuestRepository repository}) {
    _repository = repository;
  }

  Future<int> handle(List<KixikilaGuest> usersInvited) async {
    return await _repository.insertItem(usersInvited);
  }
}

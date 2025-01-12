import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';

import '../../../repositories/kixikila/i_kixikila_user_repository.dart';

class KixikilaGuestGetAllUsecase {
  late IKixikilaGuestRepository _repository;

  KixikilaGuestGetAllUsecase({required IKixikilaGuestRepository repository}) {
    _repository = repository;
  }

  Future<List<KixikilaGuest>> handle(String kixikilaId) async {
    var result = await _repository.getAllByKixikila(kixikilaId);

    return result;
  }
}

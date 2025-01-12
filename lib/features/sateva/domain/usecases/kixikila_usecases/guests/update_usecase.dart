import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';

import '../../../../../../core/error/log/catch_error_log.dart';
import '../../../repositories/kixikila/i_kixikila_user_repository.dart';

class KixikilaGuestUpdateUsecase {
  late IKixikilaGuestRepository _repository;

  KixikilaGuestUpdateUsecase({required IKixikilaGuestRepository repository}) {
    _repository = repository;
  }

  Future<int> handle(KixikilaGuest guest) async {
    try {
      return await _repository.updateItem(guest);
    } catch (error, st) {
      errorLog(error, st);
      return 0;
    }
  }
}

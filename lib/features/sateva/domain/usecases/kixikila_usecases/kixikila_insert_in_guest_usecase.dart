import 'package:kumbuz/features/sateva/domain/repositories/kixikila/i_kixikilia_repository.dart';

class KixikilaInsertInTheGuestUsecase {
  late IKixikilaRepository _repository;

  KixikilaInsertInTheGuestUsecase({required IKixikilaRepository repository}) {
    _repository = repository;
  }

  Future<int> handle({required String guestId, required String kixiID}) async {
    return await _repository.insertKixikilaInTheGuest(
        guestId: guestId, kixikilaId: kixiID);
  }
}

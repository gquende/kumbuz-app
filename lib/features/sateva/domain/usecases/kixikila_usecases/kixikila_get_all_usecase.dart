import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila.dart';
import 'package:kumbuz/features/sateva/domain/repositories/kixikila/i_kixikilia_repository.dart';

class KixikilaGetAllUsecase {
  late IKixikilaRepository _repository;

  KixikilaGetAllUsecase({required IKixikilaRepository repository}) {
    _repository = repository;
  }

  Future<List<Kixikila>> handle(String userId) async {
    var result = await _repository.getAll(userId);
    return result;
  }
}

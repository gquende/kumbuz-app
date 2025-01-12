import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila.dart';
import 'package:kumbuz/features/sateva/domain/repositories/kixikila/i_kixikilia_repository.dart';

class KixikilaInsertUsecase {
  late IKixikilaRepository _repository;

  KixikilaInsertUsecase({required IKixikilaRepository repository}) {
    _repository = repository;
  }

  Future<int> handle(Kixikila kixikila) async {
    return await _repository.insertItem(kixikila);
  }
}

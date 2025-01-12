import 'package:kumbuz/features/sateva/data/data_source/remote/kixikila/kixikila_firebase_datasource.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila.dart';

import '../../../domain/repositories/kixikila/i_kixikilia_repository.dart';

class KixikilaRepository implements IKixikilaRepository {
  late KixikilaRemoteDataSource _remoteDataSource;

  KixikilaRepository({required KixikilaRemoteDataSource remoteDataSource}) {
    _remoteDataSource = remoteDataSource;
  }

  @override
  Future<int> insertItem(Kixikila item) async {
    return await _remoteDataSource.insert(item.toJson()) ? 1 : 0;
  }

  @override
  Future<List<Kixikila>> getAll(String userId) async {
    var kixikilas = <Kixikila>[];

    var data = await _remoteDataSource.getKixikilas(userId);

    print("REPO::");
    print(data);

    for (var value in data) {
      var kixi = Kixikila.fromJson(value["data"]);

      kixikilas.add(kixi);
    }

    return kixikilas;
  }

  @override
  Future<int> deleteItem(Kixikila item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<Kixikila?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<int> updateItem(Kixikila item) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

  @override
  Future<int> insertKixikilaInTheGuest(
      {required String guestId, required String kixikilaId}) async {
    return await _remoteDataSource.insertInTheGuest(
            guestId: guestId, kixikilaId: kixikilaId)
        ? 1
        : 0;
  }
}

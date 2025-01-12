import 'package:flutter/cupertino.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';

import '../../../domain/repositories/kixikila/i_kixikila_user_repository.dart';
import '../../data_source/remote/kixikila/kixikila_guest_firebase_datasource.dart';

class KixikilaUserRepository implements IKixikilaGuestRepository {
  late KixikilaGuestRemoteDataSource _remoteDataSource;

  KixikilaUserRepository(
      {required KixikilaGuestRemoteDataSource remoteDataSource}) {
    _remoteDataSource = remoteDataSource;
  }

  @override
  Future<List<KixikilaGuest>> getAllByKixikila(String kixikilaId) async {
    var data = await _remoteDataSource.getUsersInvited(kixikilaId);

    print("Kixikila GUEST Get all");
    print(data);

    List<KixikilaGuest> usersInveted = [];
    for (var value in data) {
      if (value != null) {
        var user = KixikilaGuest.fromJson(value as Map);
        usersInveted.add(user);
      }
    }

    return usersInveted;
  }

  @override
  Future<int> deleteItem(KixikilaGuest item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<KixikilaGuest?> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<int> insertItem(List<KixikilaGuest> users) async {
    return await _remoteDataSource.insert(users) ? 1 : 0;
  }

  @override
  Future<int> updateItem(KixikilaGuest item) async {
    try {
      return await _remoteDataSource.update(item.toJson()) ? 1 : 0;
    } catch (error) {
      debugPrint("KixikilaUserRepository:: updateItem:: ${error.toString()}");
      return 0;
    }
  }
}

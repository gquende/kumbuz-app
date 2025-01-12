import 'package:flutter/foundation.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/data_source/remote/users/user_remote_data_source.dart';

import 'package:kumbuz/features/sateva/domain/repositories/i_user_repository.dart';

import '../../domain/entities/user_entity.dart';

class UserRepository implements IUserRepository<UserEntity> {
  late UserRemoteDataSource _remoteDataSource;
  late AppDatabase _db;
  final String _tableName = "users";

  UserRepository(UserRemoteDataSource remoteDataSource,
      {required AppDatabase db}) {
    _remoteDataSource = remoteDataSource;
    _db = db;
  }

  @override
  Future<dynamic> getById(String id) async {
    try {
      var data = await _remoteDataSource.getById(id);

      return data;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<int> update(UserEntity user) async {
    return await _remoteDataSource.update(user.toJson()) ? 1 : 0;
  }

  @override
  Future<UserEntity?> create(UserEntity data) async {
    var result = await _remoteDataSource.create(data.toJson());
    print("Tentando criar no Repo... Resultado::${result.toString()}");
    if (result != null) {
      //Update user Id
      data.id = result.user!.uid;
      return data;
    }
    return null;
  }

  @override
  Future<int> delete(String uuid) async {
    try {
      var result = _db.database.delete(_tableName, where: "uuId='$uuid'");
      return result;
    } catch (error) {
      if (kDebugMode) {
        print("UserRepository::DELETE::$error");
      }
    }

    return 0;

    // TODO: implement delete
    // throw UnimplementedError();
  }
}

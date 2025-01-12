import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';

class UserEntity extends EntityBase {
  String id;
  String name;
  String surname;
  String username;
  String password;
  String token;
  String? notificationDeviceId;

  UserEntity(
      {required this.id,
      required this.name,
      required this.surname,
      required this.username,
      required this.password,
      required this.token,
      this.notificationDeviceId,
      String? createdAt,
      String? updatedAt})
      : super(createdAt, updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'username': username,
      'password': password,
      'token': token,
      'createdAt': createAt,
      'updatedAt': updateAt,
      'notificationDeviceId': notificationDeviceId
    };
  }

  static UserEntity fromJson(Map json) {
    return UserEntity(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      username: json['username'],
      password: json['password'] ?? "",
      token: json['token'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      notificationDeviceId: json['notificationDeviceId'],
    );
  }
}

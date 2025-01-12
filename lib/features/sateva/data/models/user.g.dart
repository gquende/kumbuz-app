// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      isNumber(json['id'].toString()) ? json['id'] : 0,
      json['uuId'] ?? "0",
      json['name'] as String,
      json['surname'] as String,
      json['email'] as String,
      json['password'] as String,
      json['financialProfile'] as String,
      json['createAt'] as String,
      json['updateAt'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'id': instance.id,
      'uuId': instance.uuId,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'password': instance.password,
      'financialProfile': instance.financialProfile,
    };

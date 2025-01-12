// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      json['id'] as int,
      json['userId'] as String,
      json['name'] as String,
      (json['amount'] as num).toDouble(),
      json['excludeInTotal'] == 1,
      json['iconUrl'] as String,
      json['type'] as String,
      json['color'] as String,
      json['createAt'] as String,
      json['updateAt'] as String,
    )..uuId = json['uuId'] as String?;

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'id': instance.id,
      'uuId': instance.uuId,
      'userId': instance.userId,
      'name': instance.name,
      'amount': instance.amount,
      'excludeInTotal': instance.excludeInTotal,
      'iconUrl': instance.iconUrl,
      'type': instance.type,
      'color': instance.color,
    };

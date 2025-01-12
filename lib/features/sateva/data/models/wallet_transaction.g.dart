// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) =>
    WalletTransaction(
      json['uuId'] as String,
      json['description'] as String,
      json['walletId'] as String,
      json['itemId'] as String,
      (json['amount'] as num).toDouble(),
      json['type'] as String,
      json['date'] as String,
      json['time'] as String,
      json['createAt'] as String,
      json['updateAt'] as String,
    )..id2 = json['id2'] as int?;

Map<String, dynamic> _$WalletTransactionToJson(WalletTransaction instance) =>
    <String, dynamic>{
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'id2': instance.id2,
      'description': instance.description,
      'uuId': instance.uuid,
      'walletId': instance.walletId,
      'itemId': instance.itemId,
      'amount': instance.amount,
      'type': instance.type,
      'date': instance.date,
      'time': instance.time,
    };

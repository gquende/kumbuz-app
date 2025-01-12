// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankAccount _$BankAccountFromJson(Map<String, dynamic> json) => BankAccount(
      json['uuid'] as String?,
      json['userId'] as String?,
      json['type'] as String?,
      json['bankName'] as String?,
      json['accountNumber'] as String?,
      json['createAt'] as String,
      json['updateAt'] as String,
    )..currency = json['currency'] as String?;

Map<String, dynamic> _$BankAccountToJson(BankAccount instance) =>
    <String, dynamic>{
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'uuid': instance.uuid,
      'userId': instance.userId,
      'type': instance.type,
      'bankName': instance.bankName,
      'accountNumber': instance.accountNumber,
      'currency': instance.currency,
    };

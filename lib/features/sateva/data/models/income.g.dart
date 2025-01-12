// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Income _$IncomeFromJson(Map<dynamic, dynamic> json) => Income(
      json['id2'] as int,
      json['userId'] as String,
      json['date'] as String,
      json['time'] as String,
      (json['amount'] as num).toDouble(),
      json['description'] as String,
      json['categoryId'] as String,
      json['walletId'] as int,
      json['createAt'] as String,
      json['updateAt'] as String,
    )
      ..uuId = json['uuId'] as String?
      ..recurring = json['recurring'] == 1
      ..periodyRecurring = json['periodyRecurring'] as String?;

Map<String, dynamic> _$IncomeToJson(Income instance) => <String, dynamic>{
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'id2': instance.id2,
      'userId': instance.userId,
      'uuId': instance.uuId,
      'date': instance.date,
      'time': instance.time,
      'amount': instance.amount,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'walletId': instance.walletId,
      'recurring': instance.recurring ? 1 : 0,
      'periodyRecurring': instance.periodyRecurring,
    };

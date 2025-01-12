// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<dynamic, dynamic> json) => Expense(
      json['id'] as int,
      json['userId'] as String,
      json['date'] as String,
      json['time'] as String,
      (json['amount'] as num).toDouble(),
      json['description'] as String,
      json['category'] as String,
      json['walletId'] as int,
      json['createAt'] as String,
      json['updateAt'] as String,
    )
      ..uuId = json['uuId'] as String?
      ..recurring = json['recurring'] == 1
      ..periodyRecurring = json['periodyRecurring'] as String?;

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      // 'id': instance.id,
      'userId': instance.userId,
      'uuId': instance.uuId,
      'date': instance.date,
      'time': instance.time,
      'amount': instance.amount,
      'description': instance.description,
      'category': instance.category,
      'walletId': instance.walletId,
      'recurring': instance.recurring ? 1 : 0,
      'periodyRecurring': instance.periodyRecurring,
    };

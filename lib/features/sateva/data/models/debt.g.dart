// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Debt _$DebtFromJson(Map<String, dynamic> json) => Debt(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      userId: json['userId'] as String,
      walletId: json['walletId'] as String,
      type: json['type'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      amountTarget: (json['amountTarget'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      date: json['date'] as String,
      time: json['time'] as String,
      description: json['description'] as String,
      color: json['color'] as String,
      isDone: json['isDone'] as bool,
      createAt: json['createAt'] as String,
      updateAt: json['updateAt'] as String,
    );

Map<String, dynamic> _$DebtToJson(Debt instance) => <String, dynamic>{
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      // 'id': instance.id,
      'uuid': instance.uuid,
      'userId': instance.userId,
      'walletId': instance.walletId,
      'type': instance.type,
      'from': instance.from,
      'to': instance.to,
      'amountTarget': instance.amountTarget,
      'amount': instance.amount,
      'date': instance.date,
      'time': instance.time,
      'isDone': instance.isDone,
      'description': instance.description,
      'color': instance.color,
    };

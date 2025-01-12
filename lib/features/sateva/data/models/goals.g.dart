// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goals _$GoalsFromJson(Map<String, dynamic> json) => Goals(
      id: json['id'] as int,
      uuId: json['uuId'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      amountTarget: (json['amountTarget'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      targetDate: json['targetDate'] as String,
      date: json['date'] as String,
      isDone: json['isDone'] as bool,
      percentDone: (json['percentDone'] as num?)?.toDouble(),
      color: json['color'] as String?,
      createAt: json['createAt'] as String?,
      updateAt: json['updateAt'] as String?,
    );

Map<String, dynamic> _$GoalsToJson(Goals instance) => <String, dynamic>{
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'id': instance.id,
      'uuId': instance.uuId,
      'userId': instance.userId,
      'name': instance.name,
      'amountTarget': instance.amountTarget,
      'amount': instance.amount,
      'date': instance.date,
      'targetDate': instance.targetDate,
      'color': instance.color,
      'percentDone': instance.percentDone,
      'isDone': instance.isDone,
    };

DepositGoals _$DepositGoalsFromJson(Map<String, dynamic> json) => DepositGoals(
      json['id'] as int,
      json['idGoals'] as int,
      json['date'] as String,
      json['time'] as String,
      (json['amount'] as num).toDouble(),
      json['description'] as String,
    );

Map<String, dynamic> _$DepositGoalsToJson(DepositGoals instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idGoals': instance.idGoals,
      'date': instance.date,
      'time': instance.time,
      'amount': instance.amount,
      'description': instance.description,
    };

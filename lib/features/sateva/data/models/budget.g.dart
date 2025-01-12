// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
      json['id'] as int,
      json['uuid'] as String,
      json['categoryId'] as String,
      json['userUUId'] as String,
      json['name'] as String,
      json['category'] as String,
      (json['amount'] as num).toDouble(),
      (json['amountConsume'] as num?)?.toDouble(),
      json['initialDate'] as String,
      json['endDate'] as String,
      (json['percentComplete'] as num?)?.toDouble(),
      json['createAt'] as String,
      json['updateAt'] as String,
    );

Map<String, dynamic> _$BudgetToJson(Budget instance) => <String, dynamic>{
      'createAt': instance.createAt,
      'updateAt': instance.updateAt,
      'id': instance.id,
      'uuid': instance.uuid,
      'categoryId': instance.categoryId,
      'userUUId': instance.userUUId,
      'name': instance.name,
      'category': instance.category,
      'amount': instance.amount,
      'amountConsume': instance.amountConsume,
      'initialDate': instance.initialDate,
      'endDate': instance.endDate,
      'percentComplete': instance.percentComplete,
    };

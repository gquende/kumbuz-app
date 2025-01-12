// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
        json['id'] as int,
        json['uuid'] as String,
        json['userId'] as String,
        json['name'] as String,
        json['color'] as String,
        json['iconUrl'] as String,
        (json['value'] as num).toDouble(),
        json["type"] ?? "");

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'userId': instance.userId,
      'name': instance.name,
      'color': instance.color,
      'iconUrl': instance.iconUrl,
      'value': instance.value,
      'id': instance.id,
      'type': instance.type ?? "",
    };

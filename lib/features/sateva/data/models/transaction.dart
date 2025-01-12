// import 'package:floor/floor.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:meu_kumbu/features/sateva/domain/entities/entity_base.dart';
//
// part 'transaction.g.dart';
//
// @JsonSerializable()
// @Entity(tableName: 'transactions2')
// class Transaction extends EntityBase {
//   final int id;
//   int? goalId;
//   int? debId;
//   final String uuid;
//   final String title;
//   final String description;
//   final double amount;
//   final String date;
//   final String iconUrl;
//   final String type;
//
//   Transaction(
//       {required this.id,
//       required this.uuid,
//       required this.title,
//       required this.description,
//       required this.amount,
//       required this.date,
//       required this.iconUrl,
//       required this.type,
//       required String dateCreate,
//       required String dateUpdate})
//       : super(dateCreate, dateUpdate);
//
//   String getTime() => '${date.hour.toString().padLeft(2, '0')}:'
//       '${date.minute.toString().padLeft(2, '0')} '
//       '${date.hour >= 0 && date.hour <= 12 ? 'AM' : 'PM'}';
// }
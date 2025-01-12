import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';

part 'goals.g.dart';

@JsonSerializable()
@Entity(tableName: "goals")
class Goals extends EntityBase {
  @PrimaryKey(autoGenerate: true)
  int id;
  String uuId;
  String userId;
  String name;
  double amountTarget;
  double amount;
  String date;
  String targetDate;
  String? color;
  double? percentDone;
  bool isDone;

  Goals(
      {required this.id,
      required this.uuId,
      required this.userId,
      required this.name,
      required this.amountTarget,
      required this.amount,
      required this.targetDate,
      required this.date,
      required this.isDone,
      this.percentDone,
      this.color,
      String? createAt,
      String? updateAt})
      : super(createAt, updateAt);

  factory Goals.fromJson(Map<String, dynamic> json) => _$GoalsFromJson(json);
  Map<String, dynamic> json() => _$GoalsToJson(this);
}

@JsonSerializable()
class DepositGoals {
  int id;
  int idGoals;
  String date;
  String time;
  double amount;
  String description;

  factory DepositGoals.fromJson(Map<String, dynamic> json) =>
      _$DepositGoalsFromJson(json);
  Map<String, dynamic> toJson() => _$DepositGoalsToJson(this);

  DepositGoals(this.id, this.idGoals, this.date, this.time, this.amount,
      this.description);
}
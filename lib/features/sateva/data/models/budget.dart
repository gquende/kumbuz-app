import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';

part 'budget.g.dart';

@JsonSerializable()
@Entity(tableName: "budgets")
class Budget extends EntityBase {
  @PrimaryKey(autoGenerate: true)
  int id;
  String uuid;
  String categoryId;
  String userUUId;
  String name;
  String category;
  double amount;
  double? amountConsume;
  String initialDate;
  String endDate;

  // String date;
  // String time;

  double? percentComplete = 0;
  Budget(
      this.id,
      this.uuid,
      this.categoryId,
      this.userUUId,
      this.name,
      this.category,
      this.amount,
      this.amountConsume,
      this.initialDate,
      this.endDate,
      this.percentComplete,
      String createAt,
      String updateAt)
      : super(createAt, updateAt);
  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);
  Map<String, dynamic> toJson() => _$BudgetToJson(this);
}
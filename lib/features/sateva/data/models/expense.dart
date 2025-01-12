import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';
import 'package:uuid/uuid.dart';

part 'expense.g.dart';

@JsonSerializable()
@Entity(tableName: "expenses")
class Expense extends EntityBase {
  @PrimaryKey(autoGenerate: true)
  int id;
  String userId;
  String? uuId = Uuid().v4();
  String date;
  String time;
  double amount;
  String description;
  String category;
  int walletId;
  bool recurring = false;
  String? periodyRecurring;

  Expense(
      this.id,
      this.userId,
      this.date,
      this.time,
      this.amount,
      this.description,
      this.category,
      this.walletId,
      String createAt,
      String updateAt)
      : super(createAt,
            updateAt); // Expense(this.id, this.walletId, this.userId, this.recurring, this.amount,
  //     this.description, this.category);

  factory Expense.fromJson(Map<dynamic, dynamic> json) =>
      _$ExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}

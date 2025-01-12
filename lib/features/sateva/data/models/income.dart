import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';
import 'package:uuid/uuid.dart';

part 'income.g.dart';

@JsonSerializable()
@Entity(tableName: 'incomes')
class Income extends EntityBase {
  @PrimaryKey(autoGenerate: true)
  // @primaryKey()
  late int id2;
  String userId;
  String? uuId = const Uuid().v4();
  String date;
  String time;
  double amount;
  String description;
  String categoryId;
  String? category = "";
  int walletId;
  bool recurring = false;
  String? periodyRecurring;

  Income(
      this.id2,
      this.userId,
      this.date,
      this.time,
      this.amount,
      this.description,
      this.categoryId,
      this.walletId,
      String createAt,
      String updateAt)
      : super(createAt, updateAt);

  Income.withouID(
      this.id2,
      this.userId,
      this.date,
      this.time,
      this.amount,
      this.description,
      this.categoryId,
      this.walletId,
      String createAt,
      String updateAt)
      : super(createAt, updateAt);

  factory Income.fromJson(Map<dynamic, dynamic> json) => _$IncomeFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeToJson(this);

  @override
  String toString() {
    // TODO: implement toString
    super.toString();

    return "[Id2: ${this.id2}, UUID: ${this.uuId}, UserID: ${this.userId}, Amount: ${this.amount}, Category: ${this.categoryId}, Description: ${this.description}, Date: ${this.date}, Time: ${this.time}, WalletId: ${this.walletId}";
  }
}

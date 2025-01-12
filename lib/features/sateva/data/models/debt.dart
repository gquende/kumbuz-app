import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';

part 'debt.g.dart';

@JsonSerializable()
@Entity(tableName: 'debts')
class Debt extends EntityBase {
  @PrimaryKey(autoGenerate: true)
  late int id;
  String uuid;
  String userId;
  String walletId;
  String type;
  String from;
  String to;
  double amountTarget;
  double amount;
  String date;
  String time;
  bool isDone;
  String description;
  // int idWallet;
  String color;
  double? percentDone;

  Debt(
      {required this.id,
      required this.uuid,
      required this.userId,
      required this.walletId,
      required this.type,
      required this.from,
      required this.to,
      required this.amountTarget,
      required this.amount,
      required this.date,
      required this.time,
      required this.description,
      required this.color,
      required this.isDone,
      required String createAt,
      required String updateAt})
      : super(createAt, updateAt);

  factory Debt.fromJson(Map<String, dynamic> json) => _$DebtFromJson(json);
  Map<String, dynamic> toJson() => _$DebtToJson(this);

  @override
  String toString() {
    return 'Debt{id: $id, uuid: $uuid, userId: $userId, walletId: $walletId, type: $type, from: $from, to: $to, '
        'amountTarget: $amountTarget, amount: $amount, date: $date, time: $time, isDone: $isDone, '
        'description: $description, color: $color, percentDone: $percentDone}';
  }
}

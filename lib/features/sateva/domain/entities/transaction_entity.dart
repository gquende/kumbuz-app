import 'entity_base.dart';

class TransactionEntity extends EntityBase {
  String uuid;
  String description;
  String walletId;
  String itemId;
  double amount;
  String type;
  String date;
  String time;

  TransactionEntity(
      {required this.uuid,
      required this.walletId,
      required this.description,
      required this.type,
      required this.itemId,
      required this.amount,
      required this.date,
      required this.time,
      String? createdAt,
      String? updatedAt})
      : super(createdAt, updatedAt);

  @override
  String toString() {
    return 'TransactionEntity { '
        'uuid: $uuid, '
        'description: $description, '
        'walletId: $walletId, '
        'itemId: $itemId, '
        'amount: $amount, '
        'type: $type, '
        'date: $date, '
        'time: $time, '
        'createdAt: ${super.createAt}, '
        'updatedAt: ${super.updateAt}'
        '}';
  }
}

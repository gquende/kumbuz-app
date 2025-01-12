import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/transaction_entity.dart';

part 'wallet_transaction.g.dart';

@JsonSerializable()
@Entity(tableName: "transactions")
class WalletTransaction extends TransactionEntity {
  @PrimaryKey(autoGenerate: true)
  int? id2;
  // String description;
  // String? uuId;
  // String walletId;
  // String itemId;
  // double amount;
  // String type;
  // String date;
  // String time;

  WalletTransaction(
      String uuId,
      String description,
      String walletId,
      String itemId,
      double amount,
      String type,
      String date,
      String time,
      String createAt,
      String updateAt)
      : super(
          uuid: uuId,
          walletId: walletId,
          itemId: itemId,
          type: type,
          amount: amount,
          description: description,
          date: date,
          time: time,
          createdAt: createAt,
          updatedAt: updateAt,
        );

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
  Map<String, dynamic> toJson() => _$WalletTransactionToJson(this);
}

List<WalletTransaction> transactionsMock = [
  WalletTransaction("1", "Compra de pao", "0", "1", 20000, "Despesa",
      "2022-04-05", "12:20", "2022-04-05", "2022-04-05"),
  WalletTransaction("2", "Yougurte", "2", "2", 2000, "Despesa", "2022-04-05",
      "12:20", "2022-04-05", "2022-04-05"),
  WalletTransaction("3", "Manga", "3", "3", 20000, "Despesa", "2022-04-05",
      "12:20", "2022-04-05", "2022-04-05")
];

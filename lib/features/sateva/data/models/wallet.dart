import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';
part 'wallet.g.dart';

@JsonSerializable()
@Entity(tableName: "wallets")
class Wallet extends EntityBase {
  @PrimaryKey(autoGenerate: true)
  int id;
  String? uuId;
  String userId;
  String name;
  double amount;
  bool excludeInTotal;
  String iconUrl;
  String type;
  String color;
  // List<WalletTransaction> transactions;

  Wallet(this.id, this.userId, this.name, this.amount, this.excludeInTotal,
      this.iconUrl, this.type, this.color, String createAt, String updateAt)
      : super(createAt, updateAt);

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}

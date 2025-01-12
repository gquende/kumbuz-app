import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';

part 'bank_account.g.dart';

@JsonSerializable()
@Entity(tableName: "bank_accounts")
class BankAccount extends EntityBase {
  @PrimaryKey(autoGenerate: true)
  String? uuid;
  String? userId;
  String? type;
  String? bankName;
  String? accountNumber;
  String? currency;

  BankAccount(
      this.uuid,
      this.userId,
      this.type,
      this.bankName,
      //this.description,
      this.accountNumber,
      //this.token,
      String createAt,
      String updateAt)
      : super(createAt, updateAt);

  factory BankAccount.fromJson(Map<String, dynamic> json) =>
      _$BankAccountFromJson(json);
  Map<String, dynamic> toJson() => _$BankAccountToJson(this);
}

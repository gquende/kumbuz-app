import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';

import '../../../../utils/utils.dart';

part 'user.g.dart';

@JsonSerializable()
@Entity(tableName: "users")
class User extends EntityBase {
  @PrimaryKey(autoGenerate: true)
  int id;
  String uuId;
  String name;
  String surname;
  String email;
  String password;
  String financialProfile;

  User(this.id, this.uuId, this.name, this.surname, this.email, this.password,
      this.financialProfile, String createAt, String updateAt)
      : super(createAt, updateAt);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
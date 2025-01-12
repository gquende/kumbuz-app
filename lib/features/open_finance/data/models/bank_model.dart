import 'package:kumbuz/features/open_finance/domain/entity/bank_entity.dart';

class BankModel extends Bank {
  double balance = 0;

  BankModel(
      {required this.balance,
      required String uuid,
      required String name,
      required String bic,
      required String logoUrl})
      : super(uuid, name, bic, logoUrl);

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'uuid': uuid,
      'name': name,
      'bic': bic,
      'logoUrl': logoUrl,
    };
  }

  factory BankModel.fromJson(Map json) {
    return BankModel(
      balance: json['balance'] ?? 0,
      uuid: json['uuid'],
      name: json['name'],
      bic: json['bic'],
      logoUrl: json['logoUrl'],
    );
  }
}

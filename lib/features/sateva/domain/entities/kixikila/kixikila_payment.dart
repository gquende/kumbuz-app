import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';
import 'package:uuid/uuid.dart';

class KixikilaPayment extends EntityBase {
  String? id = const Uuid().v4();
  String kixikilaId;
  String userId;
  String? userName;
  double amount;
  String status;
  String paymentDate;

  KixikilaPayment({
    this.id,
    required this.kixikilaId,
    required this.userId,
    required this.amount,
    required this.status,
    this.userName,
    required this.paymentDate,
    String? createdAt,
    String? updatedAt,
  }) : super(createdAt, updatedAt) {}

  Map<String, dynamic> toJson() {
    return {
      'kixikilaId': kixikilaId,
      'id': id,
      'userId': userId,
      'amount': amount,
      'status': status,
      'paymentDate': paymentDate,
      'userName': userName,
      'createdAt': createAt,
      'updatedAt': updateAt
    };
  }

  factory KixikilaPayment.fromJson(Map<dynamic, dynamic> json) {
    return KixikilaPayment(
      kixikilaId: json['kixikilaId'],
      id: json['id'],
      userId: json['userId'],
      amount: double.parse("${json['amount']}"),
      status: json['status'],
      paymentDate: json['paymentDate'],
      userName: json['userName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

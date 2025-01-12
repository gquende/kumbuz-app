import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';
import 'package:uuid/uuid.dart';

class Kixikila extends EntityBase {
  String? id = const Uuid().v4();
  String description;

  String paymentDate; //Type of payment
  String? nextPaymentDate;
  int? nextUserToReceive;
  double amount;
  String status;
  String createdBy;
  int? numberOfGuest = 0;

  Kixikila(
      {this.id,
      required this.description,
      required this.paymentDate,
      required this.status,
      required this.createdBy,
      required this.amount,
      this.nextPaymentDate,
      this.nextUserToReceive,
      this.numberOfGuest,
      String? createdAt,
      String? updatedAt})
      : super(createdAt, updatedAt) {
    id ??= const Uuid().v4();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'paymentDate': paymentDate,
      'amount': amount,
      'nextPaymentDate': nextPaymentDate,
      'nextUserToReceive': nextUserToReceive,
      'status': status,
      'createdBy': createdBy,
      'numberOfGuest': numberOfGuest,
    };
  }

  factory Kixikila.fromJson(Map json) {
    return Kixikila(
      id: json['id'],
      description: json['description'],
      paymentDate: json['paymentDate'],
      nextPaymentDate: json['nextPaymentDate'],
      nextUserToReceive: json['nextUserToReceive'],
      status: json['status'],
      numberOfGuest: json['numberOfGuest'],
      amount: double.parse("${json['amount']}"),
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

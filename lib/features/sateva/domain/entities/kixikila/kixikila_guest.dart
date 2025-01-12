import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';
import 'package:uuid/uuid.dart';

class KixikilaGuest extends EntityBase {
  String? id = const Uuid().v4();
  String kixikilaId;
  String userId;
  String user;
  String status;
  String lastPaymentDate;
  int paymentSequence;

  KixikilaGuest({
    this.id,
    required this.kixikilaId,
    required this.userId,
    required this.user,
    required this.paymentSequence,
    required this.lastPaymentDate,
    required this.status,
    String? createdAt,
    String? updatedAt,
  }) : super(createdAt, updatedAt);

  Map<String, dynamic> toJson() {
    return {
      'kixikilaId': kixikilaId,
      'id': id,
      'userId': userId,
      'lastPaymentDate': lastPaymentDate,
      'user': user,
      'paymentSequence': paymentSequence,
      'status': status,
      'createdAt': createAt,
      'updatedAt': updateAt,
    };
  }

  factory KixikilaGuest.fromJson(Map json) {
    return KixikilaGuest(
      id: json['id'],
      kixikilaId: json['kixikilaId'],
      userId: json['userId'],
      user: json['user'],
      lastPaymentDate: json['lastPaymentDate'],
      status: json['status'],
      paymentSequence: json['paymentSequence'],
      createdAt: json['createAt'],
      updatedAt: json['updateAt'],
    );
  }
}

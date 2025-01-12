enum TypeNotification { transaction, bot }

class NotificationEntity {
  String type;
  String id;
  String title;
  String message;
  DateTime dateTime;
  String status;

  NotificationEntity(
      {required this.id,
      required this.title,
      required this.message,
      required this.dateTime,
      required this.status})
      : type = "bot";

  NotificationEntity.transaction(
      {required this.id,
      required this.title,
      required this.message,
      required this.dateTime,
      required this.status})
      : type = "transaction";

  NotificationEntity.info(
      {required this.id,
      required this.title,
      required this.message,
      required this.dateTime,
      required this.status})
      : type = "info";

  NotificationEntity.warning(
      {required this.id,
      required this.title,
      required this.message,
      required this.dateTime,
      required this.status})
      : type = "warning";

  NotificationEntity.success(
      {required this.id,
      required this.title,
      required this.message,
      required this.dateTime,
      required this.status})
      : type = "success";

  factory NotificationEntity.empty() {
    return NotificationEntity(
        id: "", title: "", message: "", dateTime: DateTime.now(), status: "");
  }

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    var not = NotificationEntity(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      dateTime: DateTime.parse(json['datetime']),
      status: json['status'],
    );

    not.type = json['type'];

    return not;
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type, // Salvando o enum como índice
      'id': id,
      'title': title,
      'message': message,
      'datetime':
          dateTime.toIso8601String(), // Convertendo DateTime para string ISO
      'status': status,
    };
  }
}

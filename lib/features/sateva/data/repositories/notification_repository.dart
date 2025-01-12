import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/domain/entities/notification.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_notification_repository.dart';

class NotificationRepository
    extends INotificationRepository<NotificationEntity> {
  late AppDatabase _db;
  final String _tableName = "notifications";

  NotificationRepository(AppDatabase db) {
    _db = db;
  }

  @override
  Future<int> insert(NotificationEntity item) async {
    var result = await _db.database.insert(_tableName, item.toJson());
    return result;
  }

  @override
  Future<int> update(NotificationEntity item) async {
    var result = await _db.database
        .update(_tableName, item.toJson(), where: "id='${item.id}'");
    return result;
  }

  @override
  Future<int> delete(NotificationEntity item) async {
    return await _db.database.delete(_tableName, where: "id='${item.id}'");
  }

  @override
  Future<List<NotificationEntity>> getAll() async {
    var data = await _db.database
        .rawQuery("SELECT * FROM ${_tableName} ORDER BY datetime DESC");

    if (data.isNotEmpty) {
      return data.map((element) {
        return NotificationEntity.fromJson(element);
      }).toList();
    }

    return [];
  }
}

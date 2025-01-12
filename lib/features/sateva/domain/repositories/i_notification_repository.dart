import 'package:kumbuz/features/sateva/domain/entities/notification.dart';

abstract class INotificationRepository<T extends NotificationEntity> {
  Future<dynamic> insert(T item);
  Future<int> delete(T item);
  Future<int> update(T item);
  Future<List<T>> getAll();
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/domain/entities/notification.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_notification_repository.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationEntity>[].obs;

  NotificationController() {
    getNotifications();
  }

  Future<void> getNotifications() async {
    try {
      var repo = DI.get<INotificationRepository>();
      notifications.value = await repo.getAll();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updateNotificationStatus(
      NotificationEntity not, String status) async {
    try {
      not.status = status;
      var repo = DI.get<INotificationRepository>();
      await repo.update(not);
      getNotifications();
    } catch (error) {
      debugPrint("Controller:: ${error.toString()}");
    }
  }
}

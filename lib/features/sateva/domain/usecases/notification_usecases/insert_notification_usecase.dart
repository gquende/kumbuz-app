import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/domain/entities/notification.dart';
import 'package:kumbuz/features/sateva/domain/repositories/i_notification_repository.dart';

class InsertNotificationUsecase extends ChangeNotifier {
  late INotificationRepository _repository;

  InsertNotificationUsecase(INotificationRepository repo) : _repository = repo;

  Future<int> handle(NotificationEntity notification) async {
    try {
      await _repository.insert(notification);

      notifyListeners();
    } catch (error) {
      debugPrint("InsertNotificationUsecase:: ${error.toString()}");
    }

    return 0;
  }
}

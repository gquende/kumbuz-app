import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/domain/entities/notification.dart';

class OpenNotification extends StatelessWidget {
  NotificationEntity notificationEntity;

  OpenNotification({super.key, required this.notificationEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notificationEntity.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Text(notificationEntity.message),
        ),
      ),
    );
  }
}

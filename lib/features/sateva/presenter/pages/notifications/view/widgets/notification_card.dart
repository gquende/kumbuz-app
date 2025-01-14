import 'package:flutter/material.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/presenter/pages/notifications/controller/notification_controller.dart';

import '../../../../../../../configs/theme/styles.dart';
import '../../../../../../../core/di/dependecy_injection.dart';
import '../../../../../domain/entities/notification.dart';
import '../open_notification.dart';

class NotificationCard extends StatefulWidget {
  NotificationEntity notificationEntity;

  NotificationCard({super.key, required this.notificationEntity});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  var controller = DI.get<NotificationController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OpenNotification(
                    notificationEntity: widget.notificationEntity,
                  )));
          controller.updateNotificationStatus(
              widget.notificationEntity, "read");
          setState(() {});
        },
        child: Container(
          width: size.width,
          decoration: AppStyles.containerDecoration(context),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.notificationEntity.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.notificationEntity.message),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      DateTimeManipulation.getFormatDateForSQLite(
                          widget.notificationEntity.dateTime),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.grey),
                    )
                  ],
                ),
              ),
              widget.notificationEntity.status == "noread"
                  ? Positioned(
                      left: size.width * 0.88,
                      top: 20,
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: Theme.of(context).primaryColor,
                      ))
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

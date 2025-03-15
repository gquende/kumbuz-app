import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/presenter/pages/notifications/controller/notification_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/notifications/view/notification_page.dart';
import 'package:provider/provider.dart';

import '../../../../features/sateva/domain/usecases/notification_usecases/insert_notification_usecase.dart';

class NotificationIcon extends StatefulWidget {
  const NotificationIcon({super.key});

  @override
  State<NotificationIcon> createState() => _NotificationIconState();
}

class _NotificationIconState extends State<NotificationIcon> {
  var controller = DI.get<NotificationController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<InsertNotificationUsecase>();
    controller.getNotifications();
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationPage()));
      },
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          children: [
            const Positioned(
              top: 6,
              child: Icon(
                Icons.notifications_none_sharp,
                size: 28,
              ),
            ),
            Obx(() {
              return controller.notifications
                          .where((not) => not.status == "noread")
                          .length >
                      0
                  ? Positioned(
                      right: 12,
                      top: 5,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const NotificationPage()));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 9,
                          child: Text(
                            "${controller.notifications.where((not) => not.status == "noread").length}",
                            style: TextStyle(fontSize: 11, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                  : SizedBox();
            })
          ],
        ),
      ),
    );
  }
}

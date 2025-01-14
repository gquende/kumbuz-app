import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kumbuz/configs/assets.dart';
import 'package:kumbuz/features/sateva/presenter/pages/notifications/view/widgets/notification_card.dart';

import '../../../../../../core/di/dependecy_injection.dart';
import '../controller/notification_controller.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var controller = DI.get<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notificações"),
          centerTitle: true,
        ),
        body: Obx(() {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: controller.notifications.value.length == 0
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(AppAssets.EMPTY_NOTIFICATION),
                        width: 400,
                      ),
                      Text(
                        "Sem notificações!",
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ))
                : Column(
                    children: controller.notifications.value.map((element) {
                      return NotificationCard(notificationEntity: element);
                    }).toList(),
                  ),
          ));
        }));
  }
}

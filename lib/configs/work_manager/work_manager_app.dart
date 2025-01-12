import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

Future showNotification() async {
  int rndmIndex = Random().nextInt(55 - 1);

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    '$rndmIndex.0',
    '2k2kej2',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics, iOS: null);

  await flutterLocalNotificationsPlugin.show(
    rndmIndex,
    'Teste de notificação',
    "testando",
    platformChannelSpecifics,
  );

  /// periodically...but const id && const title,body
  /*await flutterLocalNotificationsPlugin.periodicallyShow(
    Random().nextInt(azkar.length-1),
    'السلام عليكم',
    azkar[Random().nextInt(azkar.length-1)],
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    payload: '',
  );*/
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
void callbackDispatcher() {
  // initial notifications
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: null,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  WidgetsFlutterBinding.ensureInitialized();

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  Workmanager().executeTask((task, inputData) {
    print("Tarefa em segundo plano: $task");
    switch (task) {
      case "simpleTask":
        {
          showNotification();
        }
        break;
      default:
        {
          showNotification();
          print("Testabd");
        }
        break;
    }
    return Future.value(true);
  });
}

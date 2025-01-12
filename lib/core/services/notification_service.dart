import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
//import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:timezone/timezone.dart' as tz;

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String? payload;
  final Map<String, dynamic>? data;
  final RemoteMessage? remoteMessage;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    this.data,
    this.payload,
    this.remoteMessage,
  });
}

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupAndroidDetails();
    _setupNotifications();
  }

  _setupAndroidDetails() {
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications_details',
      'Lembretes',
      channelDescription: 'Este canal é para lembretes!',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await DateTime.now().timeZoneName;
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    // Fazer: macOs, iOS, Linux...
    await localNotificationsPlugin.initialize(
        const InitializationSettings(
          android: android,
        ),
        onDidReceiveNotificationResponse: _onSelectNotification2,
        onDidReceiveBackgroundNotificationResponse: _onSelectNotification2
        // onSelectNotification: _onSelectNotification,
        );
  }

  static _onSelectNotification2(NotificationResponse response) async {
    if (response.payload != null) {
      if (response.payload!.isNotEmpty) {
        var data = jsonDecode(response.payload as String);
      }
      // var fuelSupply = FuelSupplyModel.fromMapServer(data);
      // Navigator.of(Routes.navigatorKey!.currentContext!).push(MaterialPageRoute(
      //     builder: (_) => FuelSupplyDetails(fuelSupply: fuelSupply)));
    }
  }

  _onSelectNotification(String? payload, {Map<String, dynamic>? data}) {
/*
    supplies = [];
    (widget.carData["fuel_data"] as List).forEach((element) {
      var fuelSupply = FuelSupplyModel.fromMapServer(element);
      supplies.add(fuelSupply);
    });
*/

    if (payload != null && payload.isNotEmpty) {
      var data = jsonDecode(payload);
      // var fuelSupply = FuelSupplyModel.fromMapServer(data);
      // Navigator.of(Routes.navigatorKey!.currentContext!).push(MaterialPageRoute(
      //     builder: (_) => FuelSupplyDetails(fuelSupply: fuelSupply)));
    }
  }

  showNotificationScheduled(
      CustomNotification notification, Duration duration) {
    final date = DateTime.now().add(duration);

    localNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(date, tz.local),
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  showLocalNotification(CustomNotification notification) {
    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
      ),
      payload: notification.payload,
    );
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.notificationResponse?.payload ?? "");
    }
  }
}

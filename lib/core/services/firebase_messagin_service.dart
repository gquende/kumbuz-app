import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_service.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');

    await messaging.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );

    messaging.sendMessage();
    _onMessage();
    _onMessageOpenedApp();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        //var data = jsonDecode(notification.body!);
        // var payload = jsonEncode(data['fuel_supply'][0] ?? '');

        _notificationService.showLocalNotification(
          CustomNotification(
            id: android.hashCode,
            title: notification.title!,
            body: notification.body as String,
            payload: "payload",
          ),
        );
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    //var payload = jsonEncode(message['fuel_supply'][0] ?? '');
    final String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      // Routes.navigatorKey?.currentState?.pushNamed(route);
    }
  }
}

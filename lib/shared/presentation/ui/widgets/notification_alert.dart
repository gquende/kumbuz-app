import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NotificationAlert {
  static void show(String title, String message, Widget icon, Color color) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: color.withOpacity(.7),
      title: title,
      isDismissible: true,
      duration: const Duration(milliseconds: 2000),
      icon: icon,
      message: message,
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      snackStyle: SnackStyle.FLOATING,
      barBlur: 30,
    ));
  }
}

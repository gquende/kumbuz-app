import 'package:flutter/material.dart';
import 'package:kumbuz/core/db/database.dart';

import 'environments/environments.dart';

class AppEnvironment {
  static var env = Environment.prod;
}

class AppFiles {
  static const String done_animation = "assets/animations/done.json";
  static const String conversation_animation =
      "assets/animations/conversation.json";

  static const String loading_animation = "assets/animations/loading.json";
  static const String LOGO = "assets/images/logo.png";

  static const String LOGO2 = "assets/images/logo2.png";
  static const String APP_LOADING = "assets/animations/app-loading.json";

  static const Onboarding1 = "assets/images/money_control.svg";
}

class AppColors {
  static final backgroundColor = Colors.white;

  //Other Good Color
  static const primaryColor = Color(0xFF665ced);
  static final bgColor = Color(0xFFf5f5f5);
  static final greyColor = Color(0xfff6f6f8);
  static final textPrimaryColor = Color(0xFF2f2c58);
  static final textSecundaryColor = Color(0xFF90939c);
}

class AppConfiguration {
  static late AppDatabase database;
}

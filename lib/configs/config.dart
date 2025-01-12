import 'package:flutter/material.dart';

import 'package:kumbuz/core/db/database.dart';

import 'environments/environments.dart';

class AppEnvironment {
  static var env = Environment.prod;
}

class AppFiles {
  static String done_animation = "assets/animations/done.json";
  static String conversation_animation = "assets/animations/conversation.json";
  static String loading_animation = "assets/animations/loading.json";
  static String LOGO = "assets/images/logo.png";
  static String LOGO2 = "assets/images/logo2.png";
  static final String APP_LOADING = "assets/animations/app-loading.json";
  static final Onboarding1 = "assets/images/money_control.svg";
}

class AppColors {
  static final backgroundColor = Colors.white;
  //Other Good Color
  static final primaryColor = Color(0xFF665ced);
  static final bgColor = Color(0xFFf5f5f5);
  static final greyColor = Color(0xfff6f6f8);
  static final textPrimaryColor = Color(0xFF2f2c58);
  static final textSecundaryColor = Color(0xFF90939c);
}

class AppConfiguration {
  static late AppDatabase database;
}

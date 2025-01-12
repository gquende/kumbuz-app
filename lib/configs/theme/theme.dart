import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/configs/theme/text_button_theme.dart';
import 'package:kumbuz/configs/theme/text_theme.dart';
import 'package:kumbuz/configs/theme/textfield_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_bar_theme.dart';
import 'bottom_sheet_theme.dart';
import 'button_theme.dart';
import 'checkbox_theme.dart';
import 'colors.dart';
import 'elevated_theme.dart';
import 'icon_theme.dart';

class AppTheme2 {
  static var isDarkMode = false.obs;

  static get light => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: PRIMARY_COLOR,
      primaryColorDark: secondary,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      textTheme: TTextTheme.lightTextTheme,
      checkboxTheme: TCheckBoxTheme.lightCheckButtonTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButton,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
      buttonTheme: TButtonTheme.lightButtonTheme,
      textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
      iconTheme: TIconTheme.lightAppBarTheme,
      unselectedWidgetColor: Colors.black12,
      cardColor: Colors.white,
      highlightColor: red,
      splashColor: green,
      datePickerTheme: const DatePickerThemeData(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Color(0xffe5e5e5),
          dayStyle: TextStyle(color: Colors.black),
          dayForegroundColor: WidgetStatePropertyAll(Colors.black),
          headerBackgroundColor: Colors.grey,
          weekdayStyle: TextStyle(color: Colors.black)),
      colorScheme: ColorScheme.dark(
          primary: PRIMARY_COLOR,
          background: Colors.white,
          secondary: secondary,
          primaryContainer: Colors.white,
          secondaryContainer: Color(0xffe5e5e5)));

  static get darkMode => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xff181719),
      primaryColor: PRIMARY_COLOR,
      primaryColorDark: secondary,
      colorScheme: ColorScheme.dark(
          primary: PRIMARY_COLOR,
          background: const Color(0xff181719),
          secondary: const Color(0xff1F222B),
          primaryContainer: const Color(0xff232224),
          secondaryContainer: const Color(0xff2C2C2D)),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
          color: Colors.transparent,
          titleTextStyle: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
      textTheme: TTextTheme.darkTextTheme,
      checkboxTheme: TCheckBoxTheme.darkCheckButtonTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButton,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
      buttonTheme: TButtonTheme.darkButtonTheme,
      textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
      iconTheme: TIconTheme.darkAppBarTheme);

  static setDarkMode(bool value) async {
    isDarkMode.value = value;
    var shared = await SharedPreferences.getInstance();
    shared.setBool("themeMode", value);
  }

  static Future<bool> loadThemeMode() async {
    var shared = await SharedPreferences.getInstance();
    isDarkMode.value = shared.getBool("themeMode") ?? false;

    return isDarkMode.value;
  }
}

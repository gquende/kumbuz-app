import 'package:flutter/material.dart';
import 'package:kumbuz/configs/theme/colors.dart';

class TCheckBoxTheme {
  static final lightCheckButtonTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected))
          return Colors.white;
        else
          return Colors.black;
      }),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected))
          return PRIMARY_COLOR;
        else
          return Colors.transparent;
      }));

  static final darkCheckButtonTheme = CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      checkColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected))
          return Colors.white;
        else
          return Colors.black;
      }),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected))
          return PRIMARY_COLOR;
        else
          return Colors.transparent;
      }));
}

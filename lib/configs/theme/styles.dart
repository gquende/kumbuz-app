import 'package:flutter/material.dart';

class AppStyles {
  static BoxDecoration containerDecoration(BuildContext context) {
    return BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 0.2),
              spreadRadius: 0.1,
              blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(10));
  }
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  static set(BuildContext context) async {
    return await showDialog(
        barrierColor: Colors.black87,
        context: context,
        builder: (ctx) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              )));
        });
  }

  static dispose(BuildContext context) {
    Navigator.pop(
      context,
    );
  }
}

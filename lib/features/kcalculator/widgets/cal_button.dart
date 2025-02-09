import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cal_provider.dart';

class CalculateButton extends StatelessWidget {
  CalculateButton({super.key, required this.label});

  String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<CalculatorProvider>(context, listen: false).setValue("=");

        if (label.contains('OK')) {
          Navigator.of(context).pop(
              Provider.of<CalculatorProvider>(context, listen: false)
                  .compController
                  .text);
        }
      },
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

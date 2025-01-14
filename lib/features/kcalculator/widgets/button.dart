import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/config.dart';
import '../provider/cal_provider.dart';

class Button1 extends StatelessWidget {
  const Button1(
      {super.key, required this.label, this.textColor = Colors.white});

  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    //label = label.contains('/') ? '÷' : label;

    return InkWell(
      onTap: () => Provider.of<CalculatorProvider>(context, listen: false)
          .setValue(label),
      child: Material(
        elevation: 3,
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          radius: 36,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: label.contains('AC')
              ? Icon(
                  Icons.backspace,
                  color: Theme.of(context).primaryColor,
                )
              : Text(
                  label,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }
}

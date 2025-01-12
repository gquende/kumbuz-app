import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';

Container ConfirmButton(BuildContext context, String text, bool active) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.2,
    height: MediaQuery.of(context).size.width / 6.5,
    decoration: BoxDecoration(
        color: active ? AppColors.primaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(10)),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Poppins-regular',
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width / 25),
      ),
    ),
  );
}
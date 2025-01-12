import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height / 3.5,
      decoration: BoxDecoration(color: Colors.white),
    );
  }
}
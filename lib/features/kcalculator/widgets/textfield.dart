import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, required this.controller});

  final TextEditingController controller;

  // final Scroli

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextField(
        scrollController: scrollController,
        controller: controller,
        decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            filled: true),
        style: const TextStyle(fontSize: 30),
        readOnly: true,
        autofocus: true,
        showCursor: true,
        onChanged: (value) {
          scrollController.jumpTo(10000);
        },
      ),
    );
  }
}

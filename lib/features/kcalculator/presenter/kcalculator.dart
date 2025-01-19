import 'package:flutter/material.dart';
import 'package:kumbuz/features/kcalculator/presenter/widgets_data.dart';
import 'package:provider/provider.dart';

import '../provider/cal_provider.dart';
import '../widgets/cal_button.dart';
import '../widgets/textfield.dart';

class Kcalculator extends StatelessWidget {
  Kcalculator({super.key, required this.value});

  String value = '';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    const padding = EdgeInsets.symmetric(horizontal: 25, vertical: 30);
    var decoration = BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)));

    return Consumer<CalculatorProvider>(builder: (context, provider, _) {
      provider.compController.text = value;
      return Scaffold(
        // backgroundColor: Colors.black,

        body: Column(
          //spacing: 10,
          children: [
            CustomTextField(
              controller: provider.compController,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                //  height: screenHeight * 0.,
                width: double.infinity,
                padding: padding,
                decoration: decoration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) => buttonList[index]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          List.generate(4, (index) => buttonList[index + 4]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          List.generate(4, (index) => buttonList[index + 8]),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(4, (index) {
                                  if (index < 3) {
                                    return buttonList[index + 12];
                                  }

                                  return CalculateButton(label: '=');
                                }),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(4, (index) {
                                  if (index < 3) {
                                    return buttonList[index + 15];
                                  }

                                  return CalculateButton(label: 'OK');
                                }),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

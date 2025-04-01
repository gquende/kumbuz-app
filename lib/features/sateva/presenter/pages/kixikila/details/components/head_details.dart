import 'package:flutter/material.dart';
import 'package:kumbuz/utils/currency_utils.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila.dart';

import '../../../../../../../core/configs/theme/styles.dart';

class KixikilaHeadDetails extends StatelessWidget {
  Kixikila kixikila;

  KixikilaHeadDetails({super.key, required this.kixikila});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.18,
      decoration: AppStyles.containerDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currencyFormatUtils(kixikila.amount),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.group,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      " 3 Convidados",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${kixikila.nextPaymentDate}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

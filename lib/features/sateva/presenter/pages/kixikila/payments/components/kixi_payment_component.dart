import 'package:flutter/material.dart';
import 'package:kumbuz/configs/theme/styles.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_payment.dart';

import '../../../../../../../core/utils/currency_utils.dart';

class KixiPaymentComponent extends StatelessWidget {
  KixikilaPayment payment;

  KixiPaymentComponent({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 80,
      decoration: AppStyles.containerDecoration(context),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              size: 34,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
                width: 140,
                child: Expanded(
                    child: Text(
                  "${payment.userName}",
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 18),
                ))),
            SizedBox(
              width: size.width * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currencyFormatUtils(payment.amount),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    DateTimeManipulation.getFormatDateForSQLite(
                        DateTime.parse(payment.paymentDate)),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

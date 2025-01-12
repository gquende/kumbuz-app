import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';

import 'day_transaction_widget.dart';

class DayTransactiosListWidget extends StatelessWidget {
  DateTime date;
  List<WalletTransaction> transactions;
  DayTransactiosListWidget({required this.date, required this.transactions});

  // const DayTransactiosListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: size.height / 14,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${date.day}",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${DateTimeManipulation.getMonthName(date.month)} ${date.year}",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        DateTimeManipulation.getWeekDayName(date.weekday),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // Divider(
          //   color: Colors.black,
          //   height: 4,
          // ),
          Column(
            children: List.generate(transactions.length, (index) {
              return Column(
                children: [
                  DayTransactionWidget(transaction: transactions[index]),
                  // Divider()
                ],
              );
            }),
          )
        ]));
  }
}

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/domain/entities/transaction_entity.dart';
import 'package:kumbuz/features/sateva/presenter/pages/transactions/transaction_details.dart';

import '../../../../utils/wiiget_utils.dart';

class DayTransactionWidget extends StatelessWidget {
  // const DayTransactionWidget({Key? key}) : super(key: key);

  CurrencyFormatterSettings aoaSettings = CurrencyFormatterSettings(
    symbol: 'AOA',
    symbolSide: SymbolSide.right,
    thousandSeparator: ' ',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );

  TransactionEntity transaction;

  DayTransactionWidget({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                TransactionDetails(transaction: transaction)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 11,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                  blurRadius: 5)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      child: setIcon(transaction.type),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: setColor(transaction.type)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.4,
                          child: Text(
                            transaction.description,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip),
                          ),
                        ),
                        Text(
                          setText(transaction.type),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      CurrencyFormatter.format(
                          transaction.type == "expense"
                              ? -transaction.amount
                              : transaction.amount,
                          aoaSettings),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      transaction.date,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

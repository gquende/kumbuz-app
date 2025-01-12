import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:kumbuz/configs/theme/styles.dart';
import 'package:kumbuz/features/sateva/data/models/debt.dart';
import 'package:kumbuz/features/sateva/presenter/pages/debts/debt_details.dart';

import '../../../../core/utils/currency_utils.dart';

class DebtCard extends StatefulWidget {
  Debt debt;
  bool navigation = false;
  DebtCard({required this.debt, required this.navigation});

  @override
  State<DebtCard> createState() => _DebtCardState();
}

class _DebtCardState extends State<DebtCard> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: widget.navigation
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DebtDetails(debt: widget.debt)));
            }
          : null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        decoration: AppStyles.containerDecoration(context),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widget.debt.from.isEmpty
                              ? Iconify(
                                  GameIcons.take_my_money,
                                  size: 36,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Iconify(
                                  GameIcons.receive_money,
                                  size: 36,
                                  color: Theme.of(context).primaryColor,
                                ),

                          // CircleAvatar(
                          //   child: Iconify(
                          //     GameIcons.take_my_money,
                          //     size: 36,
                          //     color: Theme.of(context).primaryColor,
                          //   ),
                          // ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / 1.8,
                                child: Text(
                                  widget.debt.description,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              // currencyFormatUtils(
                              //     "${debt.amountTarget.abs()}"),

                              Text(
                                currencyFormatUtils(
                                    "${widget.debt.amountTarget.abs()}"),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Medium',
                                    color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              const Divider(
                height: 9,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${((widget.debt.amount / widget.debt.amountTarget) * 100).round()}% Pago",
                            style: const TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 16,
                                color: Colors.grey),
                            // style: Text(),
                          ),
                          Text(
                            currencyFormatUtils("${widget.debt.amount.abs()}"),
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 18,
                                color: Colors.pinkAccent),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.debt.amountTarget -
                                        (widget.debt.amount as double) >=
                                    0
                                ? "Restante"
                                : "Ultrapassou!",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 16,
                                color: Colors.grey),
                            // style: Text(),
                          ),
                          Text(
                            currencyFormatUtils(
                                "${widget.debt.amountTarget - (widget.debt.amount as double)}"),
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 18,
                                color: Colors.blue),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: (size.width - 40),
                        height: 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xff67727d).withOpacity(0.1)),
                      ),
                      Container(
                        width: (size.width - 40) *
                            (((widget.debt.amount / widget.debt.amountTarget) *
                                    100 as double) /
                                100),
                        height: 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.pinkAccent),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

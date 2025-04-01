import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/features/sateva/data/models/budget.dart';
import 'package:kumbuz/features/sateva/presenter/pages/budget_details.dart';

import '../../../../core/configs/theme/styles.dart';
// import 'package:provider/provider.dart';

class BudgetCard extends StatelessWidget {
  // const BudgetCart({Key? key}) : super(key: key);
  Budget budget;

  BudgetCard({required this.budget});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BudgetDetails(budget: budget)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        decoration: AppStyles.containerDecoration(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                          CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: const Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width / 1.8,
                                child: Text(
                                  '${budget.name}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Bold',
                                      color: Colors.black54),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '${CurrencyFormatter.format(budget.amount.abs(), GetIt.instance.get<CurrencyFormatterSettings>())}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Poppins-SemiBold',
                                    color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BudgetDetails(budget: budget)));
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color(0xffe5e5e5),
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                        ),
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
                            "${budget.percentComplete!.round()}% Gasto",
                            style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                fontSize: 16,
                                color: Colors.grey),
                            // style: Text(),
                          ),
                          Text(
                            "${CurrencyFormatter.format(budget.amountConsume, GetIt.instance.get<CurrencyFormatterSettings>())}",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 18,
                                color: AppColors.primaryColor),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            budget.amount - (budget.amountConsume as double) >=
                                    0
                                ? "Restante"
                                : "Ultrapassou!",
                            style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                fontSize: 16,
                                color: Colors.grey),
                            // style: Text(),
                          ),
                          Text(
                            "${CurrencyFormatter.format(budget.amount - (budget.amountConsume as double), GetIt.instance.get<CurrencyFormatterSettings>())}",
                            style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                fontSize: 18,
                                color: Colors.grey),
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
                            ((budget.percentComplete as double) / 100),
                        height: 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.primaryColor),
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

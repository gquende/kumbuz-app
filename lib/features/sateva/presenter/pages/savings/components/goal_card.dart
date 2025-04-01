import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kumbuz/core/configs/theme/styles.dart';
import 'package:kumbuz/features/sateva/data/models/goals.dart';
import 'package:kumbuz/features/sateva/domain/usecases/goals_usecases.dart';
import 'package:provider/provider.dart';
import '../goals_details.dart';

class GoalCard extends StatefulWidget {
  // const BudgetCart({Key? key}) : super(key: key);
  Goals goal;
  bool canNavigate;
  GoalCard({super.key, required this.goal, required this.canNavigate});

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  @override
  Widget build(BuildContext context) {
    context.watch<GoalsUsecases>();
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: widget.canNavigate
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GoalDetails(goal: widget.goal)));
            }
          : null,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4.8,
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
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.savings,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: size.width / 1.8,
                                child: Text(
                                  "${widget.goal.name}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Bold',
                                      color: Colors.black54),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${CurrencyFormatter.format(widget.goal.amountTarget.abs(), GetIt.instance.get<CurrencyFormatterSettings>())}",
                                style: TextStyle(
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
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) =>
                          //         BudgetDetails(budget: budget)));
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                          ),
                          backgroundColor: Color(0xffe5e5e5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
              Divider(
                height: 9,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.goal.percentDone!.round()}% Alcançado",
                            style: TextStyle(
                                fontFamily: 'PoppinsRegular',
                                fontSize: 16,
                                color: Colors.grey),
                            // style: Text(),
                          ),
                          Text(
                            "${CurrencyFormatter.format(widget.goal.amount, GetIt.instance.get<CurrencyFormatterSettings>())}",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 18,
                                color: Colors.green),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.goal.amountTarget -
                                        (widget.goal.amount as double) >=
                                    0
                                ? "Restante"
                                : "Ultrapassou!",
                            style: TextStyle(
                                fontFamily: 'PoppinsRegular',
                                fontSize: 16,
                                color: Colors.grey),
                            // style: Text(),
                          ),
                          Text(
                            "${CurrencyFormatter.format(widget.goal.amountTarget - (widget.goal.amount as double), GetIt.instance.get<CurrencyFormatterSettings>())}",
                            style: TextStyle(
                                fontFamily: 'Poppins',
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
                            ((widget.goal.percentDone as double) / 100),
                        height: 12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green),
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

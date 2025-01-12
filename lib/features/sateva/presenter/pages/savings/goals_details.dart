import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/singletons/globals.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/calculator/calculator.dart';
import 'package:kumbuz/features/sateva/data/models/goals.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/wallet_%20controller.dart';
import 'package:kumbuz/features/sateva/domain/usecases/goals_usecases.dart';
import 'package:kumbuz/features/sateva/presenter/widget/day_transaction_widget.dart';
import 'package:kumbuz/features/sateva/presenter/pages/savings/components/goal_card.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class GoalDetails extends StatefulWidget {
  // const GoalDetails({Key? key}) : super(key: key);
  Goals goal;

  GoalDetails({required this.goal});

  @override
  State<GoalDetails> createState() => _GoalDetailsState();
}

class _GoalDetailsState extends State<GoalDetails> {
  @override
  Widget build(BuildContext context) {
    context.watch<WalletController>();
    context.watch<GoalsUsecases>();

    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text(
          "${widget.goal.name}",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<WalletController>(
          builder: (_, controller, child) {
            return Column(
              children: [
                //Todo Trocar por um card sem click
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GoalCard(
                    goal: widget.goal,
                    canNavigate: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: context
                      .read<WalletController>()
                      .getWalletTransaction(widget.goal.uuId),
                  builder: (ctx, snap) {
                    if (!snap.hasData) {
                      return Center(
                        child: Text("Sem transacções"),
                      );
                    }
                    debugPrint("Goal UUID: ${widget.goal.uuId}");
                    var goalsTransactions =
                        snap.data as List<WalletTransaction>;
                    debugPrint("Lengh: ${goalsTransactions.length}");

                    return Column(
                        children: List.generate(
                      goalsTransactions.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DayTransactionWidget(
                              transaction: goalsTransactions[index]),
                        );
                      },
                    ).toList());
                  },
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => Calculator()));

          if (calculatorResult.isNotEmpty && calculatorResult != "0") {
            WalletTransaction goalTransaction = WalletTransaction(
                Uuid().v4(),
                "Poupança para ${widget.goal.name}",
                widget.goal.uuId,
                "",
                double.parse(calculatorResult),
                "goal",
                DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
                TimeOfDay.now().toString(),
                DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
                DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));

            widget.goal.amount =
                widget.goal.amount + double.parse(calculatorResult);
            if (widget.goal.amount > widget.goal.amountTarget) {
              debugPrint("Ultrapassou o limite do objectivo");
              widget.goal.amount = widget.goal.amountTarget;
            }
            widget.goal.percentDone =
                (widget.goal.amount / widget.goal.amountTarget) * 100;

            if (!widget.goal.isDone) {
              context
                  .read<WalletController>()
                  .addWalletTransaction(goalTransaction);
              await context.read<GoalsUsecases>().updateGoal(widget.goal);
            }

            calculatorResult = "";

            if (widget.goal.percentDone! >= 100) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Objectivo alcançado!"),
                backgroundColor: Colors.green,
              ));
            }
          }
          calculatorResult = "";
        },
        child: const Icon(
          Icons.savings,
          color: Colors.white,
        ),
      ),
    );
  }
}

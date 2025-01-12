import 'package:flutter/material.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/currency_utils.dart';
import '../../../../../../core/utils/datetime_manipulation.dart';
import '../../../../../../shared/presentation/ui/spacing.dart';
import '../../../../domain/usecases/controllers/expense_controlller.dart';
import '../../../../domain/usecases/controllers/wallet_ controller.dart';
import '../../../../domain/usecases/expense_usecase/add_expense_usecase.dart';
import '../../../../domain/usecases/transactions_usecase/get_sum_transaction_by_type.dart';
import '../../income/controller/income_controller.dart';
import '../../newhome/domain/entities/total_transaction.dart';

class TotalIncomeCard extends StatelessWidget {
  TotalTransaction totalTransaction;
  TotalIncomeCard(this.totalTransaction);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.watch<ExpenseController>();
    context.watch<IncomeController>();
    return Container(
        width: size.width * 0.40,
        height: size.height * 0.15,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 0.2),
                  spreadRadius: 0.1,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: totalTransaction.type == Type.expense
                          ? const Color(0xFFFF5454)
                          : const Color(0xFF3CDE87)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: totalTransaction.type == Type.expense
                    ? const Icon(Icons.arrow_downward_outlined,
                        size: 15, color: Color(0xFFFF5454))
                    : const Icon(Icons.arrow_upward_outlined,
                        size: 15, color: Color(0xFF3CDE87)),
              ),
              const Spacing.y(),
              const Spacer(),
              Text(
                totalTransaction.type == Type.expense ? "Despesas" : "Receitas",
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 18),
                        child: Consumer<WalletController>(
                          builder: (_, _controller, child) {
                            return ListenableBuilder(
                                listenable: DI.get<AddExpenseUsecase>(),
                                builder: (ce, w) {
                                  return FutureBuilder(
                                    future: DI
                                        .get<GetSumAmountTransactionByType>()
                                        .handle(
                                            type: "income",
                                            from: "1900-01-01",
                                            to: DateTimeManipulation
                                                .getDateOfTheLastDayOfMonth(
                                                    WalletController
                                                        .dateTimeSelected)),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<double?> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text(
                                          "0 AOA",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(fontSize: 18),
                                        );
                                      }

                                      return Text(
                                        currencyFormatUtils(snapshot.data),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(fontSize: 18),
                                      );
                                    },
                                  );
                                });
                          },
                        )

                        //| Text(
                        //|   "${totalTransaction.value}",
                        //|   style: Theme.of(context)
                        //|       .textTheme
                        //|       .titleLarge
                        //|       ?.copyWith(fontSize: 18),
                        // )

                        ),
                  ),
                  Icon(Icons.chevron_right_outlined,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ],
              ),
            ],
          ),
        ));
  }
}

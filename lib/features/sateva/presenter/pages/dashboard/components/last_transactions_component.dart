import 'package:flutter/material.dart';
import 'package:kumbuz/configs/assets.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/expense_controlller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/transactions/controller/transaction_controller.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/wallet_transaction.dart';
import '../../../../domain/usecases/controllers/wallet_ controller.dart';
import '../../../widget/day_transaction_widget.dart';
import '../../income/controller/income_controller.dart';

class LastTransactionsComponent extends StatefulWidget {
  const LastTransactionsComponent({super.key});

  @override
  State<LastTransactionsComponent> createState() =>
      _LastTransactionsComponentState();
}

class _LastTransactionsComponentState extends State<LastTransactionsComponent> {
  List<WalletTransaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    context.watch<TransactionController>();
    context.watch<ExpenseController>();
    context.watch<IncomeController>();

    var size = MediaQuery.of(context).size;

    return Consumer<WalletController>(
      builder: (_, _controller, child) {
        return FutureBuilder(
            future: _controller.getTransactions(),
            builder: (_, snap) {
              if (!snap.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              transactions = snap.data as List<WalletTransaction>;

              if (transactions.isNotEmpty) {
                return Column(
                  children: List.generate(
                      transactions.length > 6 ? 6 : transactions.length,
                      (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: DayTransactionWidget(
                          transaction: transactions[index]),
                    );
                  }),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width,
                    child: Center(
                      child: Image(
                        image: AssetImage(AppAssets.NoTransactions),
                        width: size.width * 0.45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sem transacções",
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              );

              // return Container(
              //   height: size.height / 2.5,
              //   width: size.width,
              //   child: Center(
              //     child: SvgPicture.asset(
              //       AppAssets.NoTransactions,
              //       width: size.width * 0.5,
              //     ),
              //   ),
              // );
            });
      },
    );
  }
}

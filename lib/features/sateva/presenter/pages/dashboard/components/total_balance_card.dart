import 'package:flutter/material.dart';
import 'package:kumbuz/mocks/month_mocks.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/currency_utils.dart';
import '../../../../../../core/utils/datetime_manipulation.dart';
import '../../../../domain/usecases/controllers/expense_controlller.dart';
import '../../../../domain/usecases/controllers/wallet_ controller.dart';
import '../../income/controller/income_controller.dart';
import '../../transactions/controller/transaction_controller.dart';

class TotalBalanceCard extends StatefulWidget {
  const TotalBalanceCard({super.key});

  @override
  State<TotalBalanceCard> createState() => _TotalBalanceCardState();
}

class _TotalBalanceCardState extends State<TotalBalanceCard> {
  late Month _selectedMonth;

  @override
  void initState() {
    // TODO: implement initState

    _selectedMonth = months_mocks[DateTime.now().month - 1];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TransactionController>();
    var size = MediaQuery.of(context).size;
    context.watch<ExpenseController>();
    context.watch<IncomeController>();
    return Container(
      width: size.width,
      height: size.height * 0.20,
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
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<Month>(
                              style: TextStyle(color: Colors.black45),
                              underline: Container(),
                              isExpanded: true,
                              value:
                                  months_mocks.isEmpty ? null : _selectedMonth,
                              onChanged: (value) {
                                setState(() {
                                  _selectedMonth = value!;

                                  context.read<WalletController>().setData(
                                      DateTime(DateTime.now().year,
                                          _selectedMonth.id, 1));

                                  print("DateTime::");
                                  print(WalletController.dateTimeSelected);
                                });
                              },
                              items: months_mocks
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                              dropdownColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              elevation: 0,
                            )),
                      )
                    ],
                  ),
                  const Text(
                    "Saldo",
                  ),
                  const SizedBox(height: 4),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.fontSize ??
                            20),
                    child: Consumer<WalletController>(
                        builder: (_, _controller, child) {
                      return FutureBuilder(
                          future: _controller.getBalanceOfMonth(
                              0,
                              DateTimeManipulation
                                  .getYearAndMonthForSQliteFormat(
                                      WalletController.dateTimeSelected)),
                          builder: (_, snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                currencyFormatUtils(0),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontSize: 28),
                              );
                            }
                            return Text(
                              currencyFormatUtils(snapshot.data),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 28),
                            );

                            return Text("000.00",
                                style: Theme.of(context).textTheme.labelLarge);
                          });
                    }),
                  )
                ],
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     debugPrint("Mostrat tudo");
            //   },
            //   child: Text("Ver tudo"),
            // ),
          ],
        ),
      ),
    );
  }
}

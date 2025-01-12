import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/configs/environments/environments.dart';
import 'package:kumbuz/configs/theme/colors.dart';
import 'package:kumbuz/configs/theme/styles.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/domain/entities/tips.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/add_expense_usecase.dart';
import 'package:kumbuz/features/sateva/presenter/pages/tips/controller/tips_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/transactions/controller/transaction_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/transactions/transactions_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../configs/assets.dart';
import '../../../../../core/di/dependecy_injection.dart';
import '../../../../../core/utils/currency_utils.dart';
import '../../../../../shared/presentation/ui/spacing.dart';
import '../../../data/models/wallet_transaction.dart';
import '../../../domain/usecases/controllers/wallet_ controller.dart';
import '../../../domain/usecases/transactions_usecase/get_sum_transaction_by_type.dart';

import '../newhome/domain/entities/total_transaction.dart';
import 'components/last_transactions_component.dart';
import 'components/total_balance_card.dart';
import 'components/total_expense_card.dart';
import 'components/total_income_card.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<WalletTransaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    context.watch<TransactionController>();

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            // HomeAlertFirstSteps(notifier: firstStepsNotifier),

            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacing.y(),
                    //
                    // const SizedBox(
                    //   height: 40,
                    // ),
                    AppEnvironment.env == Environment.prod
                        ? balanceCard()
                        : oldBalanceCard(),

                    const SizedBox(
                      height: 20,
                    ),

                    AppEnvironment.env == Environment.prod
                        ? FutureBuilder(
                            future: DI.get<TipsController>().getTips(),
                            builder: (_, snap) {
                              if (!snap.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snap.data == null) {
                                return Container(
                                  child: Text("Sem dicas hoje..."),
                                );
                              }

                              Tips tips =
                                  Tips(title: "", message: snap.data as String);

                              return tipsWidget(tips);
                            })
                        : SizedBox(),

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Últimas transacções",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        GestureDetector(
                            onTap: () {
                              debugPrint("Ver tudo...");

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const TransactionsPage()));
                            },
                            child: Text(
                              "Ver tudo",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: PRIMARY_COLOR, fontSize: 14),
                            ))
                      ],
                    ),
                    const Spacing.y(),

                    const SizedBox(
                      height: 20,
                    ),

                    const LastTransactionsComponent(),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 400)).then((v) {
      setState(() {});
    });
  }

  Widget balanceCard() {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.accountBalance,
          style: Theme.of(context).textTheme.labelLarge!,
        ),
        Consumer<WalletController>(builder: (_, _controller, child) {
          return FutureBuilder(
              future: _controller.getBalanceOfMonth(
                  0,
                  DateTimeManipulation.getDateOfTheLastDayOfMonth(
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
        const SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          height: size.height * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.incomes,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF3CDE87)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.arrow_upward_outlined,
                              size: 15, color: Color(0xFF3CDE87)),
                        )
                      ],
                    ),
                    Consumer<WalletController>(
                      builder: (_, controller, child) {
                        return FutureBuilder(
                          future: DI
                              .get<GetSumAmountTransactionByType>()
                              .handle(
                                  type: "income",
                                  from: "1900-01-01",
                                  to: DateTimeManipulation
                                      .getDateOfTheLastDayOfMonth(
                                          WalletController.dateTimeSelected)),
                          builder: (BuildContext context,
                              AsyncSnapshot<double?> snapshot) {
                            if (!snapshot.hasData) {
                              return Text(
                                "0 AOA",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 22, color: Colors.white),
                              );
                            }

                            return Text(
                              currencyFormatUtils(snapshot.data),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 22, color: Colors.white),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: VerticalDivider(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.expenses,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFFF5454)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.arrow_downward_outlined,
                              size: 15, color: Colors.redAccent),
                        )
                      ],
                    ),
                    // Consumer<WalletController>(
                    //   builder: (_, controller, child) {
                    //     return FutureBuilder(
                    //       future: DI
                    //           .get<GetSumAmountTransactionByType>()
                    //           .handle(
                    //               type: "expense",
                    //               from: "1900-01-01",
                    //               to: DateTimeManipulation
                    //                   .getDateOfTheLastDayOfMonth(
                    //                       WalletController.dateTimeSelected)),
                    //       builder: (BuildContext context,
                    //           AsyncSnapshot<double?> snapshot) {
                    //         if (!snapshot.hasData) {
                    //           return Text(
                    //             "0 AOA",
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .titleLarge
                    //                 ?.copyWith(
                    //                     fontSize: 22, color: Colors.white),
                    //           );
                    //         }
                    //
                    //         return Text(
                    //           currencyFormatUtils(snapshot.data),
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .titleLarge
                    //               ?.copyWith(fontSize: 22, color: Colors.white),
                    //         );
                    //       },
                    //     );
                    //   },
                    // )
                    //

                    ListenableBuilder(
                        listenable: DI.get<AddExpenseUsecase>(),
                        builder: (ce, w) {
                          return FutureBuilder(
                            future: DI
                                .get<GetSumAmountTransactionByType>()
                                .handle(
                                    type: "expense",
                                    from: "1900-01-01",
                                    to: DateTimeManipulation
                                        .getDateOfTheLastDayOfMonth(
                                            WalletController.dateTimeSelected)),
                            builder: (BuildContext context,
                                AsyncSnapshot<double?> snapshot) {
                              if (!snapshot.hasData) {
                                return Text(
                                  "0 AOA",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          fontSize: 22, color: Colors.white),
                                );
                              }

                              return Text(
                                currencyFormatUtils(snapshot.data),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 22, color: Colors.white),
                              );
                            },
                          );
                        })

                    // Consumer<WalletController>(
                    //   builder: (_, controller, child) {
                    //
                    //   },
                    // )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget oldBalanceCard() {
    return Column(
      children: [
        const TotalBalanceCard(),
        const Spacing.y(),
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: TotalIncomeCard(TotalTransaction.income(
                      text: AppLocalizations.of(context)!.incomes, value: 2))),
              const Spacing.x(),
              Expanded(
                  child: TotalExpenseCard(TotalTransaction.expense(
                      text: AppLocalizations.of(context)!.expenses, value: 2))),
            ],
          ),
        ),
        const Spacing.y(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget tipsWidget(Tips tips) {
    var size = MediaQuery.of(context).size;
    var closeTips = false.obs;

    return Obx(() {
      return closeTips.value == false
          ? Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: size.height * 0.25,
                  decoration: AppStyles.containerDecoration(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Image(
                                  image: AssetImage(AppAssets.MhadiaLogo)),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.of(context).pop();
                            //   },
                            //   child: CircleAvatar(
                            //     radius: 16,
                            //     backgroundColor: Theme.of(context).primaryColor,
                            //     child: const Icon(
                            //       Icons.close_sharp,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 8.0),
                        //   child: Text(
                        //     tips.title,
                        //     style: Theme.of(context).textTheme.titleMedium,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              tips.message,
                              style: Theme.of(context).textTheme.labelLarge,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        GestureDetector(
                          onTap: () {
                            closeTips.value = true;
                          },
                          child: Container(
                            width: 80,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).primaryColor),
                            child: const Center(
                                child: Text(
                              "Está bem",
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        )
                      ],
                    ),
                  )),
            )
          : const SizedBox();
    });
  }
}

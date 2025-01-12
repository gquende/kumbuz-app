import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:kumbuz/features/sateva/data/models/debt.dart';
import 'package:kumbuz/features/sateva/domain/usecases/debts_usecases.dart';
import 'package:kumbuz/features/sateva/presenter/pages/debts/add_debt.dart';
import 'package:kumbuz/features/sateva/presenter/pages/debts/controller/debt_controller_2.dart';
import 'package:kumbuz/features/sateva/presenter/widget/debt_card.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/theme/styles.dart';
import '../../../../../core/di/dependecy_injection.dart';
import '../../../../../core/utils/currency_utils.dart';
import '../../../../../core/utils/datetime_manipulation.dart';
import '../../../domain/usecases/controllers/wallet_ controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/usecases/expense_usecase/add_expense_usecase.dart';
import '../../../domain/usecases/transactions_usecase/get_sum_transaction_by_type.dart';
import 'debt_details.dart';

class DebtsPage extends StatefulWidget {
  const DebtsPage({super.key});

  @override
  State<DebtsPage> createState() => _DebtsPageState();
}

class _DebtsPageState extends State<DebtsPage> {
  double totalToPay = 0;
  double totalToReceive = 0;

  late DebtController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = context.read<DebtController>();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<DebtController>();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Dívidas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(children: [
            balanceCard(),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Expanded(
                  child: ContainedTabBarView(
                tabs: const [Text("Por pagar"), Text("Por receber")],
                tabBarProperties: TabBarProperties(
                    background: Container(
                      color: Colors.white,
                    ),
                    unselectedLabelStyle: TextStyle(color: Colors.black),
                    unselectedLabelColor: Colors.black54,
                    indicatorSize: TabBarIndicatorSize.tab),
                views: [DebtList(type: 1), DebtList(type: 2)],
              )),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddDebt()));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget balanceCard() {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Resumo",
          style: Theme.of(context).textTheme.labelLarge!,
        ),
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
                          "Por pagar",
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
                            border: Border.all(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.arrow_upward_outlined,
                              size: 15, color: Colors.redAccent),
                        )
                      ],
                    ),
                    FutureBuilder(
                        future: controller.getSumDebtNotDoneByType(
                            status: 1, context: context),
                        builder: (_, snap) {
                          if (!snap.hasData) {
                            return Text(
                              currencyFormatUtils("${totalToReceive}"),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 22, color: Colors.white),
                            );
                          }

                          var data = snap.data ?? 0.0;

                          return Text(
                            currencyFormatUtils(data),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 22, color: Colors.white),
                          );
                        }),
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
                          "Por receber",
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
                            border: Border.all(color: const Color(0xFF3CDE87)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.arrow_downward_outlined,
                              size: 15, color: Color(0xFF3CDE87)),
                        )
                      ],
                    ),
                    FutureBuilder(
                        future: controller.getSumDebtNotDoneByType(
                            status: 2, context: context),
                        builder: (_, snap) {
                          if (!snap.hasData) {
                            return Text(
                              currencyFormatUtils("${totalToReceive}"),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 22, color: Colors.white),
                            );
                          }

                          var data = snap.data ?? 0.0;

                          return Text(
                            currencyFormatUtils(data),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 22, color: Colors.white),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget DebtList({required int type}) {
    return SingleChildScrollView(
      child: FutureBuilder(
          future:
              controller.getDebtNotDoneByType(status: type, context: context),
          builder: (_, snap) {
            if (!snap.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var data = snap.data ?? [];

            if (data.isNotEmpty) {
              return Column(
                children: data.map((toElement) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 0.0, top: 8),
                    child: DebtItemWidget(toElement),
                  );
                }).toList(),
              );
            }

            return Container(
              height: 500,
              alignment: Alignment.center,
              child: Text("Sem dados"),
            );
          }),
    );
  }

  Widget DebtItemWidget(Debt debt) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DebtDetails(debt: debt)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
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
                          debt.from.isEmpty
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
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / 1.8,
                                child: Text(
                                  debt.to.isNotEmpty
                                      ? "Devo ${debt.to} - ${debt.description}"
                                      : "${debt.from} me deve - ${debt.description}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                currencyFormatUtils(
                                    "${debt.amountTarget.abs()}"),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          )
                        ],
                      ),
                      CircularPercentIndicator(
                          radius: 20.0,
                          lineWidth: 4.0,
                          animation: true,
                          percent: debt.amount / debt.amountTarget,
                          center: Text(
                            "${((debt.amount / debt.amountTarget) * 100).round()}%",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

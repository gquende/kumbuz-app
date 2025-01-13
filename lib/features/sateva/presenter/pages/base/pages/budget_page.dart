import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/data/models/budget.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/budget_controller.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/wallet_%20controller.dart';
import 'package:kumbuz/features/sateva/domain/usecases/debts_usecases.dart';
import 'package:kumbuz/features/sateva/domain/usecases/goals_usecases.dart';
import 'package:kumbuz/features/sateva/presenter/pages/debts/controller/debt_controller_2.dart';
import 'package:kumbuz/features/sateva/presenter/widget/budget_card.dart';
import 'package:provider/provider.dart';

// import 'c';
import '../../../../data/models/debt.dart';
import '../../../widget/debt_card.dart';
import '../../income/controller/income_controller.dart';
import '../../savings/savings_page.dart';
//import 'package:flutter_icons/flutter_icons.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late PageController _pageController = PageController();
  late Animation<double> _rotation;
  final cards = 4;

  int pageIndex = 0;
  int activeDay = 3;
  List<Budget> budgets = [];
  bool _isCardDetailsOpened() => _controller.isCompleted;

  @override
  void initState() {
    // budgets = context.read<BudgetController>().getBudgetByCategory(category)
    super.initState();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 320));
    _rotation = Tween(begin: 0.0, end: 90.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<WalletController>();
    context.watch<IncomeController>();
    context.watch<GoalsUsecases>();
    context.watch<DebtController>();
    return Scaffold(backgroundColor: Color(0xffe5e5e5), body: getBody());
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          child: ContainedTabBarView(
            tabs: [Text("Orçamentos"), Text("Objectivos"), Text("Dívidas")],
            tabBarProperties: TabBarProperties(
                background: Container(
                  color: Colors.white,
                ),
                unselectedLabelStyle: TextStyle(color: Colors.black),
                unselectedLabelColor: Colors.black54,
                indicatorSize: TabBarIndicatorSize.tab),
            views: [
              Container(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Consumer<BudgetController>(
                      builder: (_, _controller, child) {
                        return FutureBuilder(
                            future: _controller.getBudgets(),
                            builder: (context, snap) {
                              if (!snap.hasData) {
                                return const CircularProgressIndicator();
                              }

                              var data = snap.data;

                              if (data!.isEmpty) {
                                return SizedBox(
                                  height: size.height / 2.5,
                                  child: const Center(
                                    child: Text("Sem dados para mostrar..."),
                                  ),
                                );
                              }

                              return ListView(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                      children: List.generate(
                                          (snap.data as List).length, (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: BudgetCard(
                                          budget: (snap.data as List)[index]),
                                    );
                                  })),
                                ],
                              );
                            });
                      },
                    )),
              ),
              SavingsPage(
                canNavigation: false,
              ),
              Container(
                  color: Colors.white,
                  child: FutureBuilder(
                    future: context.read<DebtsUsecases>().getDebtsNotDone(),
                    builder: (ctx, snap) {
                      if (!snap.hasData) {
                        return const Center(
                          child: Text("Sem dívidas a mostrar"),
                        );
                      }
                      var debts = snap.data as List<Debt>;

                      if (debts.isEmpty) {
                        return SizedBox(
                          height: size.height / 2.5,
                          child: const Center(
                            child: Text("Sem dados para mostrar..."),
                          ),
                        );
                      }

                      return ListView(
                        children: [
                          SizedBox(height: 10),
                          Column(
                            children: List.generate(debts.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 8.0),
                                child: DebtCard(
                                  debt: debts[index],
                                  navigation: true,
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      );
                    },
                  )),
            ],
            onChange: (value) {
              setState(() {
                pageIndex = value;
              });
            },
          ),
        )
      ],
    );
  }

  // Color setTabColor(int index) {
  //   switch (index) {
  //     case 0:
  //       return AppColors.primaryColor;
  //     case 1:
  //       return Colors.green;
  //     case 2:
  //       return Colors.red;
  //   }
  //
  //   return AppColors.primaryColor;
  // }
}

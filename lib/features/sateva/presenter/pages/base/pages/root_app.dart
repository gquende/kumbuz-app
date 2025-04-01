//import 'package:flutter_icons/flutter_icons.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/core/configs/theme/colors.dart';
import 'package:kumbuz/features/open_finance/presenter/add_bank_account.dart';
import 'package:kumbuz/features/sateva/presenter/pages/debts/add_debt.dart';
import 'package:kumbuz/features/sateva/presenter/pages/predict_budget.dart';
import 'package:kumbuz/features/sateva/presenter/pages/savings/add_goals.dart';

import '../../../../../../app.dart';
import '../../expense/add_expense.dart';
import '../../home.dart';
import '../../income/income_form.dart';
import 'budget_page.dart';
import 'create_budge_page.dart';
import 'profile_page.dart';
import 'stats_page.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    Home(),
    // DailyPage(),
    StatsPage(),
    BudgetPage(),
    ProfilePage(),
    CreatBudgetPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text("Ola"),
          backgroundColor: Colors.white,
          elevation: 0.5,
          actions: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${App.user!.name} ${App.user!.surname}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontFamily: 'Poppins-SemiBold')),
                        /* Text(
                          "${App.user!.financialProfile}",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: 'Poppins-Regular',
                              fontSize: 10),
                        )

                        */
                      ],
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: SpeedDial(
          visible: true,
          children: [
            SpeedDialChild(
                label: "Receita",
                child: Icon(
                  Icons.currency_exchange,
                  color: AppColors.primaryColor,
                ),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => IncomeForm()))),
            SpeedDialChild(
                label: "Despesa",
                child: Icon(
                  Icons.get_app,
                  color: Colors.pinkAccent,
                ),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddExpense()))),
            SpeedDialChild(
                label: "Orçamento",
                child: Icon(Icons.account_balance_wallet),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NewBudget()))),
            SpeedDialChild(
                label: "Objectivo",
                child: Icon(Icons.savings),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddGoals()));

                  debugPrint("Taped on Goals");
                }),
            SpeedDialChild(
                label: "Dívida",
                child: Icon(Icons.payments),
                onTap: () {
                  debugPrint("Taped on Debt");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => AddDebt()));
                }),
            SpeedDialChild(
                label: "Conta Bancária",
                child: Icon(Icons.account_balance),
                onTap: () {
                  debugPrint("Taped on Add Bank Account");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddBankAccount()));
                })
          ],
          child: Icon(Icons.add),
          backgroundColor: AppColors.primaryColor,
        ),
        // floatingActionButton: FlutterSpeed,
        // floatingActionButton: ,
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       selectedTab(4);
        //     },
        //     child: Icon(
        //       Icons.add,
        //       size: 25,
        //     ),
        //     backgroundColor: AppColors.primaryColor
        //     //params
        //     ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Icons.calendar_month,
      Icons.query_stats,
      Icons.wallet,
      Icons.person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: PRIMARY_COLOR,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}

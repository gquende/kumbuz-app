import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kumbuz/configs/environments/environments.dart';
import 'package:kumbuz/configs/feature%20flags/feature_flags.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/presenter/pages/dashboard/dashborad.dart';
import 'package:kumbuz/features/sateva/presenter/pages/goals/create_goal.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/kixikila_page.dart';
import 'package:provider/provider.dart';

import '../../../../../../configs/config.dart';
import '../../../../../../configs/theme/colors.dart';
import '../../../../../../services/notification_service.dart';
import '../../../../../../shared/presentation/ui/widgets/notification_icon.dart';
import '../../../../../chatbot/presenter/pages/chatbot_page.dart';
import '../../../../../open_finance/presenter/add_bank_account.dart';
import '../../add_budget.dart';
import '../../base/pages/budget_page.dart';
import '../../base/pages/create_budge_page.dart';
import '../../base/pages/stats_page.dart';
import '../../debts/add_debt.dart';
import '../../expense/add_expense.dart';
import '../../income/income_form.dart';
import '../../savings/add_goals.dart';
import '../../tips/controller/tips_controller.dart';
import '../../transactions/controller/transaction_controller.dart';
import '../../user_profile/user_profile.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  int pageIndex = 0;
  List<Widget> pages = [
    const DashBoard(),
    StatsPage(),
    BudgetPage(),
    const UserProfile2(),
    CreatBudgetPage()
  ];

  var tipsController = DI.get<TipsController>();

  @override
  void initState() {
    super.initState();
    checkNotifications();
    tipsController.showDayTips(context);
  }

  checkNotifications() async {
    await DI.get<NotificationService>().checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TransactionController>();

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Chatbot()));
            },
            child: Icon(
              Icons.auto_awesome_sharp,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
          title: Text("Kumbuz"),

          actions: [
            pageIndex == 1 ? Icon(Icons.calendar_month) : SizedBox(),

            Padding(padding: EdgeInsets.all(8.0), child: NotificationIcon())
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(
          children: [
            getBody(),
          ],
        )),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatSpeedDial(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget FloatSpeedDial() {
    return FeatureFlag.openFinance.isFeatureEnabledFor(AppEnvironment.env)
        ? SpeedDial(
            visible: true,
            children: [
              CustomSpeedDialChild(
                  label: "Receita",
                  icon: Icon(
                    Icons.currency_exchange,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => IncomeForm()))),
              CustomSpeedDialChild(
                  label: "Despesa",
                  icon: Icon(
                    Icons.get_app,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddExpense()))),
              CustomSpeedDialChild(
                label: "Orçamento",
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: AppColors.primaryColor,
                ),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddBudget())),
              ),
              CustomSpeedDialChild(
                  label: "Objectivo",
                  icon: Icon(
                    Icons.savings,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () {
                    //  AddGoals

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AppEnvironment.env != Environment.dev
                                ? const CreateGoal()
                                : AddGoals()));
                  }),
              CustomSpeedDialChild(
                  label: "Dívida",
                  icon: Icon(
                    Icons.payments,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () {
                    debugPrint("Taped on Debt");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddDebt()));
                  }),
              CustomSpeedDialChild(
                  label: "Conta Bancária",
                  icon: Icon(
                    Icons.account_balance,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () {
                    debugPrint("Taped on Add Bank Account");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddBankAccount()));
                  }),
              CustomSpeedDialChild(
                  label: "Kixikila",
                  icon: Icon(
                    Icons.handshake,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () {
                    debugPrint("Taped on Add Bank Account");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KixikilaPage()));
                  })
            ],
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        : SpeedDial(
            visible: true,
            children: [
              CustomSpeedDialChild(
                  label: "Receita",
                  icon: Icon(
                    Icons.currency_exchange,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => IncomeForm()))),
              CustomSpeedDialChild(
                  label: "Despesa",
                  icon: Icon(
                    Icons.get_app,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddExpense()))),
              CustomSpeedDialChild(
                label: "Orçamento",
                icon: Icon(
                  Icons.account_balance_wallet,
                  color: AppColors.primaryColor,
                ),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddBudget())),
              ),
              CustomSpeedDialChild(
                  label: "Objectivo",
                  icon: Icon(
                    Icons.savings,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CreateGoal()));
                  }),
              CustomSpeedDialChild(
                  label: "Dívida",
                  icon: Icon(
                    Icons.payments,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () {
                    debugPrint("Taped on Debt");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddDebt()));
                  }),
              // FeatureFlag.openFinance.isFeatureEnabledFor(App.environment)? CustomSpeedDialChild(
              //     label: "Conta Bancária",
              //     icon: Icon(
              //       Icons.account_balance,
              //       color: AppColors.primaryColor,
              //     ),
              //     onTap: () {
              //       debugPrint("Taped on Add Bank Account");
              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => AddBankAccount()));
              //     }):SizedBox(),
              CustomSpeedDialChild(
                  label: "Kixikila",
                  icon: Icon(
                    Icons.handshake,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => KixikilaPage()));
                  }),
            ],
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          );
  }

  Widget getBody() {
    return SafeArea(
      child: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Icons.dashboard,
      Icons.bar_chart,
      Icons.wallet,
      Icons.person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: Theme.of(context).primaryColor,
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

  SpeedDialChild CustomSpeedDialChild(
      {required String label,
      required Icon icon,
      required VoidCallback onTap}) {
    return SpeedDialChild(
        label: label,
        child: icon,
        onTap: onTap,
        backgroundColor: Theme.of(context).cardColor,
        labelBackgroundColor: Theme.of(context).cardColor);
  }
}

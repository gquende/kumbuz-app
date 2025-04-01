import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kumbuz/features/sateva/presenter/pages/transactions/controller/transaction_controller.dart';
import 'package:kumbuz/l10n/l10n.dart';
import 'package:provider/provider.dart';

import 'core/configs/config.dart';
import 'core/configs/theme/theme.dart';
import 'core/di/dependecy_injection.dart';
import 'core/setup_app.dart';
import 'utils/navigation_service.dart';
import 'utils/router.dart';
import 'features/kcalculator/provider/cal_provider.dart';
import 'features/sateva/data/models/user.dart';
import 'features/sateva/data/models/wallet.dart';
import 'features/sateva/domain/repositories/i_notification_repository.dart';
import 'features/sateva/domain/usecases/category_usecases.dart';
import 'features/sateva/domain/usecases/controllers/budget_controller.dart';
import 'features/sateva/domain/usecases/controllers/expense_controlller.dart';
import 'features/sateva/domain/usecases/controllers/wallet_ controller.dart';
import 'features/sateva/domain/usecases/debts_usecases.dart';
import 'features/sateva/domain/usecases/goals_usecases.dart';
import 'features/sateva/domain/usecases/notification_usecases/insert_notification_usecase.dart';
import 'features/sateva/presenter/pages/base/start_view.dart';
import 'features/sateva/presenter/pages/debts/controller/debt_controller_2.dart';
import 'features/sateva/presenter/pages/income/controller/income_controller.dart';

class App extends StatelessWidget {
  static User? user;
  static Wallet? wallet;

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletController()),
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => BudgetController()),
        ChangeNotifierProvider(create: (_) => TransactionController()),
        ChangeNotifierProvider(create: (_) => ExpenseController()),
        ChangeNotifierProvider(create: (_) => IncomeController()),
        ChangeNotifierProvider(create: (_) => DebtController()),
        ChangeNotifierProvider(
            create: (_) =>
                InsertNotificationUsecase(DI.get<INotificationRepository>())),
        ChangeNotifierProvider(
            create: (_) => GoalsUsecases(AppConfiguration.database)),
        ChangeNotifierProvider(
            create: (_) => CategoryUsecases(AppConfiguration.database)),
        ChangeNotifierProvider(
            create: (_) => DebtsUsecases(AppConfiguration.database))
      ],
      child: GetMaterialApp(
          navigatorKey: locator<NavigationService>().navigationKey,
          onGenerateRoute: generateRoute,
          theme:
              AppTheme2.isDarkMode.value ? AppTheme2.darkMode : AppTheme2.light,
          darkTheme: AppTheme2.darkMode,
          supportedLocales: L10n.all,
          locale: const Locale("pt_pt"),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          debugShowCheckedModeBanner: false,
          //  home: const UserProfile2()),
          home: const StartView()),
      //home: AddExpense2()),
    );
  }
}

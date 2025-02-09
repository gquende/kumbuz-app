import 'package:flutter/cupertino.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/setup_app.dart';
import 'package:kumbuz/core/utils/navigation_service.dart';
import 'package:kumbuz/features/sateva/data/models/user.dart';
import 'package:kumbuz/features/sateva/domain/usecases/category_usecases.dart';
import 'package:kumbuz/features/sateva/presenter/pages/auth/controller/auth_controller.dart';
import 'package:kumbuz/features/sateva/presenter/viewmodels/base_model.dart';
import 'package:kumbuz/services/dynamic_link_service.dart';

import '../../../../app.dart';
import '../../../../core/singletons/globals.dart';
import '../../../../core/utils/datetime_manipulation.dart';
import '../../domain/usecases/controllers/expense_controlller.dart';
import '../widget/chart.dart';

class StartUpViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DynamicLinkService _dynamicLinkService = locator<DynamicLinkService>();

  Future handleStartUpLogic() async {
    await Future.delayed(Duration(seconds: 5));
    await initApp();
  }

  // Future<void> mockTest() async {
  //   App.user = await AuthController.isLogged();
  //   //Todo Carregar o Wallet
  //   bool? openFirstTime = await AuthController.openFirsTime();
  //
  //   if (openFirstTime == null || openFirstTime == true) {
  //     debugPrint("The app is open first time");
  //
  //     if (App.user == null) {
  //       App.user = User(
  //           0,
  //           Uuid().v4(),
  //           "Adolfo",
  //           "Quende",
  //           "gquende@meukumbu.com",
  //           "adolfo",
  //           "Perfil Financeiro",
  //           "test",
  //           "Test");
  //       App.wallet = Wallet(1, App.user!.uuId, "Base", 4000, false, "", "base",
  //           "", DateTime.now().toString(), DateTime.now().toString());
  //
  //       //AppConfiguration.database.categoryDao.insertItem()
  //
  //       await AppConfiguration.database!.categoryDao.insertItem(CategoryModel(
  //           1,
  //           Uuid().v4(),
  //           App.user!.uuId,
  //           "Alimentação",
  //           "#2E1F27",
  //           "",
  //           0,
  //           "expense"));
  //       await AppConfiguration.database!.categoryDao.insertItem(CategoryModel(
  //           2,
  //           Uuid().v4(),
  //           App.user!.uuId,
  //           "Transporte",
  //           "#DD7230",
  //           "",
  //           0,
  //           "expense"));
  //       await AppConfiguration.database!.categoryDao.insertItem(CategoryModel(
  //           3,
  //           Uuid().v4(),
  //           App.user!.uuId,
  //           "Educação",
  //           "#1C5D99",
  //           "",
  //           0,
  //           "expense"));
  //       await AppConfiguration.database!.categoryDao.insertItem(CategoryModel(4,
  //           Uuid().v4(), App.user!.uuId, "Saúde", "#639FAB", "", 0, "expense"));
  //       await AppConfiguration.database!.categoryDao.insertItem(CategoryModel(
  //           5,
  //           Uuid().v4(),
  //           App.user!.uuId,
  //           "Outros",
  //           "#4F5D75",
  //           "",
  //           0,
  //           "expense"));
  //       await AppConfiguration.database!.categoryDao.insertItem(CategoryModel(
  //           6,
  //           Uuid().v4(),
  //           App.user!.uuId,
  //           "Compras",
  //           "#EF8354",
  //           "",
  //           0,
  //           "expense"));
  //
  //       WalletController walletController = WalletController();
  //       await walletController.addWallet(Wallet(
  //           1,
  //           App.user!.uuId,
  //           "Base",
  //           0,
  //           false,
  //           "",
  //           "base",
  //           "",
  //           DateTime.now().toString(),
  //           DateTime.now().toString()));
  //       await AuthController.setOpenFirstTime(false);
  //       await loadData();
  //       // App.wallet!.id = 1;
  //     }
  //
  //     _navigationService.popAtHome();
  //
  //     //_navigationService.goToTestPage();
  //   } else {
  //     debugPrint("Not Open first time");
  //     //await loadData();
  //     if (App.user == null) {
  //       App.user = User(
  //           0,
  //           const Uuid().v4(),
  //           "Adolfo",
  //           "Quende",
  //           "gquende@meukumbu.com",
  //           "adolfo",
  //           "Perfil Financeiro",
  //           "test",
  //           "Test");
  //       App.wallet = await AppConfiguration.database!.walletDao.getById(1);
  //       //Todo Delete This debugPrint when tests finish
  //       debugPrint("This is the ID: ${App.wallet!.amount}");
  //       await loadData();
  //       // _navigationService.navigateTo(AppRoutes.ViewTest);
  //       _navigationService.popAtHome();
  //       // _navigationService.goToTestPage();
  //     }
  //   }
  // }

  Future<void> initApp() async {
    App.user = await AuthController.isLogged();
    bool? openFirstTime = await AuthController.openFirsTime();

    if (openFirstTime == null || openFirstTime == true) {
      debugPrint("The app is open first time");

      _navigationService.goToOnBoarding();
    } else {
      debugPrint("Not Open first time");
      //await loadData();
      if (App.user == null) {
        App.user = User(
            0,
            "firebase",
            "Adolfo",
            "Quende",
            "gquende@meukumbu.com",
            "adolfo",
            "Perfil Financeiro",
            "test",
            "Test");
        App.wallet = await AppConfiguration.database!.walletDao.getById(1);
        //Todo Delete This debugPrint when tests finish
        debugPrint("This is the ID: ${App.wallet!.amount}");
        await loadData();
        // _navigationService.navigateTo(AppRoutes.ViewTest);
        _navigationService.popAtHome();
        // _navigationService.goToTestPage();
      } else {
        App.wallet = await AppConfiguration.database!.walletDao.getById(1);
        await loadData();

        _navigationService.popAtHome();
        //_navigationService.goToTestPage();
      }
    }
  }

  Future<void> loadData() async {
    var expenseController = locator<ExpenseController>();
    var categoryUsecases = locator<CategoryUsecases>();

    print("Qwerty...");

    String dateTime =
        DateTimeManipulation.getYearAndMonthForSQliteFormat(DateTime.now());
    String month = "${DateTime.now().month}";

    await loadExpenseChartData(dateTime, month: month);
    ExpensePerCategoryGlobalList =
        (await expenseController.getSumByCategoryOfMonth(dateTime)) ?? [];
    GlobalExpenseCategoryList = (await categoryUsecases.getAllCategory())!;
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as authFB;
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/data/models/user.dart';
import 'package:kumbuz/features/sateva/domain/entities/user_entity.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/wallet_%20controller.dart';
import 'package:kumbuz/features/sateva/domain/usecases/user_usecases/user_create_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/user_usecases/user_get_by_id_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/user_usecases/user_logout_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/user_usecases/user_update_usecase.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../app.dart';
import '../../../../../../core/setup_app.dart';
import '../../../../../../core/singletons/globals.dart';
import '../../../../../../utils/datetime_manipulation.dart';
import '../../../../../../utils/strings_utils.dart';
import '../../../../data/models/wallet.dart';
import '../../../../domain/usecases/category_usecases.dart';
import '../../../../domain/usecases/controllers/expense_controlller.dart';
import '../../../widget/chart.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  static final authFB.FirebaseAuth auth = authFB.FirebaseAuth.instance;

  Future<bool> registerUser(User user) async {
    var createUsecase = DI.get<UserCreateUsecase>();
    print("Criando...");

    user.uuId = hashData(user.email);
    var result = await createUsecase.handle(UserEntity(
        id: user.uuId,
        name: user.name,
        surname: user.surname,
        username: user.email,
        password: user.password,
        token: ""));

    print("Result $result");

    if (result != null) {
      // user.uuId = result.id;
      var value = await AppConfiguration.database!.userDao.insertItem(user);

      var localDatabase = await SharedPreferences.getInstance();
      localDatabase.setString("user", jsonEncode(user.toJson()));
      localDatabase.setBool("isLogged", true);
      setOpenFirstTime(false);

      await _initFirstConfig();

      return true;
    }

    return false;
  }

  Future<UserEntity?> login2(String username, String password) async {
    try {
      isLoading.value = true;
      var credentials = await auth.signInWithEmailAndPassword(
          email: username, password: password);

      print("Credenciais");
      print(credentials.user?.uid);

      var getUserDataUsecase = DI.get<UserGetByIdUsecase>();

      var result = await getUserDataUsecase
          .handle(hashData(credentials.user!.email as String));

      if (result != null) {
        isLoading.value = false;
        OneSignal.initialize(dotenv.get("ONESIGNAL_APP_ID"));
        var onesignalId = await OneSignal.User.getOnesignalId();

        var user = UserEntity.fromJson(result["data"]);

        user.notificationDeviceId = onesignalId;

        DI.get<UserUpdateUsecase>().handle(user);

        App.user = User(0, user.id, user.name, user.surname, user.username,
            password, "", "", "");

        var localDatabase = await SharedPreferences.getInstance();

        localDatabase.setString("user", jsonEncode(App.user?.toJson()));

        localDatabase.setBool("isLogged", true);

        setOpenFirstTime(false);

        await _initFirstConfig();

        return user;
      }
    } catch (error) {
      print("LOGIN:: ERROR:: ${error.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  // static Future<User?> login(String username, String password) async {
  //   //Todo Fazer login na cloud
  //   return await AppConfiguration.database!.userDao
  //       .getByUsernameAndPassword(username, password);
  // }

  Future<int> logout() async {
    try {
      var usecase = DI.get<UserLogoutUsecase>();
      var id = await usecase.handle(App.user!.uuId);
      return id ?? 0;
    } catch (error) {
      debugPrint(error.toString());
      return 0;
    }
  }

  static Future<User?> isLogged() async {
    var localDatabase = await SharedPreferences.getInstance();
    var isLogged = localDatabase.getBool("isLogged") ?? false;
    if (isLogged) {
      User user =
          User.fromJson(jsonDecode(localDatabase.getString("user") as String));
      return user;
    }
    return null;
  }

  static Future<void> setOpenFirstTime(bool value) async {
    try {
      SharedPreferences storage = await SharedPreferences.getInstance();
      storage.setBool('openFirsTime', value);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static Future<bool?> openFirsTime() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getBool('openFirsTime');
  }

  _initFirstConfig() async {
    App.wallet = Wallet(1, App.user!.uuId, "Base", 0, false, "", "base", "",
        DateTime.now().toString(), DateTime.now().toString());

    WalletController walletController = WalletController();
    await walletController.addWallet(App.wallet as Wallet);

    await loadData();
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

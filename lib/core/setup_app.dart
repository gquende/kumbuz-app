import 'package:currency_formatter/currency_formatter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../features/sateva/data/models/category_model.dart';
import '../firebase_options.dart';
import 'di/dependecy_injection.dart';

GetIt locator = GetIt.instance;

Future<void> setupApp() async {
  await dotenv.load();

  SharedPreferences storage = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  locator.registerSingleton(const CurrencyFormat(
    symbol: 'AOA',
    symbolSide: SymbolSide.right,
    thousandSeparator: ' ',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  ));

  AppConfiguration.database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  OneSignal.Notifications.requestPermission(true);

  await DependencyInjection().setup();

  var isFirstConfig = storage.getBool("isFirstConfig");

  OneSignal.initialize(dotenv.get("ONESIGNAL_APP_ID"));

  if (isFirstConfig == null) {
    //Expense Categories
    AppConfiguration.database.categoryDao.insertItem(CategoryModel(
        1, Uuid().v4(), "base", "Alimentação", "#2E1F27", "", 0, "expense"));
    AppConfiguration.database.categoryDao.insertItem(CategoryModel(
        2, "base", "base", "Transporte", "#DD7230", "", 0, "expense"));
    AppConfiguration.database.categoryDao.insertItem(CategoryModel(
        3, Uuid().v4(), "base", "Educação", "#1C5D99", "", 0, "expense"));
    AppConfiguration.database.categoryDao.insertItem(CategoryModel(
        4, Uuid().v4(), "base", "Saúde", "#639FAB", "", 0, "expense"));
    AppConfiguration.database.categoryDao.insertItem(CategoryModel(
        5, Uuid().v4(), "base", "Outros", "#4F5D75", "", 0, "expense"));
    AppConfiguration.database.categoryDao.insertItem(CategoryModel(
        6, Uuid().v4(), "base", "Compras", "#EF8354", "", 0, "expense"));

    //Incomes category
    AppConfiguration.database.categoryDao.insertItem(CategoryModel(
        7, Uuid().v4(), "base", "Salário", "#EF8354", "", 0, "income"));

    AppConfiguration.database.categoryDao.insertItem(CategoryModel(
        8, Uuid().v4(), "base", "Investimento", "#EF8354", "", 0, "income"));

    AppConfiguration.database.categoryDao.insertItem(CategoryModel(
        9, Uuid().v4(), "base", "Prêmios", "#EF8354", "", 0, "income"));
  }

  storage.setBool("isFirstConfig", false);
}

import 'package:flutter/material.dart';
import 'package:kumbuz/core/setup_app.dart';
import 'package:workmanager/workmanager.dart';

import 'app.dart';
import 'configs/config.dart';
import 'configs/environments/environments.dart';
import 'configs/work_manager/work_manager_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppEnvironment.env = Environment.dev;
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await setupApp();

  runApp(const App());
}

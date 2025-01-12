import 'package:flutter/material.dart';
import 'package:kumbuz/core/setup_app.dart';
import 'package:workmanager/workmanager.dart';
import 'app.dart';
import 'configs/work_manager/work_manager_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  //
  // Workmanager().registerPeriodicTask(
  //   "1",
  //   "simpleTask",
  //   frequency: const Duration(seconds: 3),
  // );
  //
  // Workmanager().registerPeriodicTask(
  //   "uniquePeriodicTaskId",
  //   "simpleTask2",
  //   inputData: <String, dynamic>{
  //     'key': 'value',
  //   },
  //   frequency:
  //       Duration(seconds: 2), // Required: interval between task executions
  //   initialDelay:
  //       Duration(seconds: 5), // Optional: delay before the first execution
  //   constraints: Constraints(
  //     networkType: NetworkType
  //         .connected, // Optional: constraints on when the task can run
  //   ),
  // );

  await setupApp();

  runApp(const App());
}

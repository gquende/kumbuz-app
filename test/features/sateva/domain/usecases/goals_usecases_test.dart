import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/models/goals.dart';
import 'package:kumbuz/features/sateva/domain/usecases/goals_usecases.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:uuid/uuid.dart';

void main() {
  GoalsUsecases? usecases;
  AppDatabase? database;
  setUp(() async {
    database = await $FloorAppDatabase.databaseBuilder("app.db").build();
    usecases = GoalsUsecases(database!);
  });

  test("Inset Goals on Database", () async {
    Random randomId = Random(200);
    int idGenerated = randomId.nextInt(100);

    Goals novo = Goals(
        id: idGenerated,
        uuId: Uuid().v4(),
        userId: Uuid().v4(),
        name: "Test",
        amountTarget: 20000,
        amount: 0,
        date: DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
        isDone: false,
        percentDone: 0,
        createAt: "",
        updateAt: "",
        targetDate:
            DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));

    int? idGetted = await usecases!.insertGoal(novo);
    expect(idGetted, equals(idGenerated));
  });
  test("Delete Goals on Database", () async {
    Random randomId = Random(20);
    int idGenerated = randomId.nextInt(100);

    Goals novo = Goals(
        id: idGenerated,
        uuId: Uuid().v4(),
        userId: Uuid().v4(),
        name: "Test",
        amountTarget: 20000,
        amount: 0,
        date: DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
        isDone: false,
        percentDone: 0,
        createAt: "",
        updateAt: "",
        targetDate:
            DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));

    await usecases!.insertGoal(novo);
    int? isDeleted = await usecases!.deleteGoal(novo);
    expect(isDeleted, equals(1));
  });

  // test("Update Goals on Database", () async {
  //   Random randomId = Random(200);
  //   int idGenerated = randomId.nextInt(100);
  //
  //   Goals novo = Goals(
  //       id: idGenerated,
  //       uuId: Uuid().v4(),
  //       userId: Uuid().v4(),
  //       name: "Test",
  //       amountTarget: 20000,
  //       amount: 0,
  //       date: DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
  //       isDone: false,
  //       percentDone: 0,
  //       createAt: "",
  //       updateAt: "",
  //       targetDate:
  //       DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));
  //
  //   int? idGetted = await usecases!.insertGoal(novo);
  //   expect(idGetted, equals(idGenerated));
  // });
  // test("Get Goals on Database", () async {
  //   Random randomId = Random(200);
  //   int idGenerated = randomId.nextInt(100);
  //
  //   Goals novo = Goals(
  //       id: idGenerated,
  //       uuId: Uuid().v4(),
  //       userId: Uuid().v4(),
  //       name: "Test",
  //       amountTarget: 20000,
  //       amount: 0,
  //       date: DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
  //       isDone: false,
  //       percentDone: 0,
  //       createAt: "",
  //       updateAt: "",
  //       targetDate:
  //       DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));
  //
  //   int? idGetted = await usecases!.insertGoal(novo);
  //   expect(idGetted, equals(idGenerated));
  // });
  //
}
import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/configs/config.dart';

import 'package:kumbuz/core/db/database.dart';

import 'package:kumbuz/features/sateva/data/models/budget.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/budget_controller.dart';

import 'package:kumbuz/utils/datetime_manipulation.dart';
import 'package:uuid/uuid.dart';

main() {
  late BudgetController controller;
  setUp(() async {
    AppConfiguration.database =
        await $FloorAppDatabase.databaseBuilder('app.db').build();
    controller = BudgetController();
  });

  test("Create Budget", () async {
    Budget novo = Budget(
        0,
        Uuid().v4(),
        "Alimenta",
        Uuid().v4(),
        "Piteu",
        "Alimenta",
        40000,
        0,
        DateTimeManipulation.getDateOfTheFirstDayOfMonth(DateTime.now()),
        DateTimeManipulation.getDateOfTheLastDayOfMonth(DateTime.now()),
        0,
        DateTime.now().toString(),
        DateTime.now().toString());
    var id = await BudgetController().createBudget(novo);
    expect(id, isNotNull);
  });

  test("Delete Budget", () async {
    Budget novo = Budget(
        0,
        Uuid().v4(),
        "Alimentacao",
        Uuid().v4(),
        "Comida de Casa",
        "Alimentacao",
        40000,
        0,
        DateTimeManipulation.getDateOfTheFirstDayOfMonth(DateTime.now()),
        DateTimeManipulation.getDateOfTheLastDayOfMonth(DateTime.now()),
        0,
        DateTime.now().toString(),
        DateTime.now().toString());
    var id = await controller.deleteBudget(novo);
    expect(id, isNotNull);
  });

  test("Get Budget ID", () async {
    Budget? budget = await controller.getBudgetByID(1);
    expect(budget, isNotNull);
    expect(budget!.id, equals(1));
  });

  test("Get Budget for a period", () async {
    // Budget novo = Budget(
    //     0,
    //     Uuid().v4(),
    //     "Alimentacao",
    //     Uuid().v4(),
    //     "Comida de Casa",
    //     "Alimentacao",
    //     40000,
    //     0,
    //     DateTimeManipulation.getDateOfTheFirstDayOfMonth(DateTime.now()),
    //     DateTimeManipulation.getDateOfTheLastDayOfMonth(DateTime.now()),
    //     0,
    //     DateTime.now().toString(),
    //     DateTime.now().toString());
    // var id = await BudgetController().createBudget(novo);
    // expect(id, isNotNull);

    // novo = Budget(
    //     0,
    //     Uuid().v4(),
    //     "Alimentacao",
    //     Uuid().v4(),
    //     "Comida de Casa",
    //     "Alimentacao",
    //     40000,
    //     0,
    //     "2022-01-01",
    //     "2022-01-31",
    //     0,
    //     DateTime.now().toString(),
    //     DateTime.now().toString());
    // id = await BudgetController().createBudget(novo);
    // expect(id, isNotNull);

    // novo = Budget(
    //     0,
    //     Uuid().v4(),
    //     "Alimentacao",
    //     Uuid().v4(),
    //     "Comida de Casa",
    //     "Alimentacao",
    //     40000,
    //     0,
    //     "2022-02-01",
    //     "2022-02-28",
    //     0,
    //     DateTime.now().toString(),
    //     DateTime.now().toString());
    // id = await BudgetController().createBudget(novo);
    // expect(id, isNotNull);

    // novo = Budget(
    //     0,
    //     Uuid().v4(),
    //     "Alimentacao",
    //     Uuid().v4(),
    //     "Comida de Casa",
    //     "Alimentacao",
    //     40000,
    //     0,
    //     "2022-03-1",
    //     "2022-03-31",
    //     0,
    //     DateTime.now().toString(),
    //     DateTime.now().toString());
    // id = await BudgetController().createBudget(novo);
    // expect(id, isNotNull);

    List<Budget>? budgetList = await controller.getBudgetForAPeriod(
        DateTimeManipulation.getDateOfTheFirstDayOfMonth(DateTime.now()));

    // expect(budgetList!.length, equals(5));
    budgetList = await controller.getBudgetForAPeriod("2022-10-01");
    expect(budgetList!.length > 0, equals(true));
  });

  test("Predict Budget", () async {
    Budget? predict =
        await controller.predictBudgetByCategory("Predict", "mes", "Teste");
    expect(predict, isNotNull);
  });
}

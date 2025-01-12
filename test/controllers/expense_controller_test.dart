import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/data/models/user.dart';
import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';
import 'package:kumbuz/features/sateva/domain/entities/transaction_entity.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/expense_controlller.dart';

import 'package:kumbuz/core/utils/datetime_manipulation.dart';

import 'package:uuid/uuid.dart';

void main() {
  late User user;
  late ExpenseController controller;
  late Wallet wallet;

  setUp(() async {
    user = User(
        1,
        Uuid().v4(),
        'Adolfo',
        'Quende',
        'gquende@hotmail.com',
        'password',
        'Poupador',
        DateTime.now().toString(),
        DateTime.now().toString());
    wallet = Wallet(0, user.uuId, "Base", 4000, false, "", "Card", "#CASESE",
        DateTime.now().toString(), DateTime.now().toString());
    AppConfiguration.database =
        await $FloorAppDatabase.databaseBuilder('app.db').build();
    controller = ExpenseController();
  });

  test('Delete Expense', () async {
    Expense expense = Expense(
        1,
        user.uuId,
        DateTimeManipulation.getYearAndMonthForSQliteFormat(DateTime.now()),
        TimeOfDay.now().toString(),
        4000,
        "Teste",
        "Teste",
        wallet.id,
        DateTime.now().toString(),
        DateTime.now().toString());

    var id = await AppConfiguration.database!.expenseDao.insertItem(expense);

    if (id != null) {
      expense.id = id as int;
      var value = await controller.deleteExpense(expense);
      expect(value, true);
    }
  });

  test('Update Expense', () async {
    Expense expense = Expense(
        1,
        user.uuId,
        DateTimeManipulation.getYearAndMonthForSQliteFormat(DateTime.now()),
        TimeOfDay.now().toString(),
        4000,
        "Teste",
        "Teste",
        wallet.id,
        DateTime.now().toString(),
        DateTime.now().toString());

    var id = await AppConfiguration.database!.expenseDao.insertItem(expense);
    if (id != null) {
      expense.id = id as int;
      expense.amount = 8000;
      // id= await AppConfiguration.database!.expenseDao.updateItem(expense)

      //   var value = await controller.updateExpense(expense);
      Expense? newExpense =
          await AppConfiguration.database!.expenseDao.getById(expense.id);
      expect(newExpense, isNotNull);
      expect(newExpense!.amount == expense.amount, true);
    }
  });

  test('Insert Expense', () async {
    Random random = Random();

    int id = random.nextInt(500);
    Expense expense = Expense(
        id,
        user.uuId,
        "2022-10-10",
        TimeOfDay.now().toString(),
        9506,
        "Teste",
        "Teste",
        wallet.id,
        DateTime.now().toString(),
        DateTime.now().toString());

    var value = await AppConfiguration.database!.expenseDao.insertItem(expense);

    // if (id != null) {
    //   expense.id = id as int;
    //   var value = await controller.deleteExpense(expense);
    expect(value, equals(id));
  });

  // controller.

  test("Get Total per Category", () async {
    List<Category>? list = await controller.getSumByCategoryOfMonth("2022-09");
    debugPrint("Category: ${list?.first.name}");
    debugPrint("Amount: ${list?.first.value}");

    expect(list, isNotNull);
  });

  test("Get Expenses by Category", () async {
    List<Expense>? list = await controller.getAllForMonthOfCategory(
        DateTimeManipulation.getYearAndMonthForSQliteFormat(DateTime.now()),
        "Teste");
    //print("Value of firts: ${list!.first.amount}");
    list!.forEach((element) {
      print("${element.category}");
    });

    expect(list, isNotNull);
  });
}

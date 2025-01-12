import 'package:flutter/material.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/data/models/category_model.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/data/models/income.dart';
import 'package:uuid/uuid.dart';

List<Expense> expenses = [
  Expense(
      1,
      Uuid().v4(),
      DateTimeManipulation.getDateOfPreviousMonth(DateTime.now()),
      TimeOfDay.now().toString(),
      700,
      "WORTEN - TERMINAL",
      "Outros",
      1,
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now())),
  Expense(
      2,
      Uuid().v4(),
      DateTimeManipulation.getDateOfPreviousMonth(DateTime.now()),
      TimeOfDay.now().toString(),
      2000,
      "SEASIDE",
      "Outros",
      1,
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now())),
  Expense(
      3,
      Uuid().v4(),
      "2022-10-10",
      TimeOfDay.now().toString(),
      9000,
      "STARA - CALÇADOS",
      "Outros",
      1,
      "2022-10-16",
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now())),
  Expense(
      4,
      Uuid().v4(),
      "2022-10-15",
      TimeOfDay.now().toString(),
      3000,
      "STARA - CALÇADOS",
      "Outros",
      1,
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now())),
  Expense(
      5,
      Uuid().v4(),
      "2022-10-18",
      TimeOfDay.now().toString(),
      15000,
      "KFC - TERMINAL",
      "Outros",
      1,
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()))
];

List<Income> incomes = [
  Income(
      1,
      Uuid().v4(),
      "2022-10-10",
      TimeOfDay.now().toString(),
      5000,
      "TREX",
      "Outros",
      1,
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now())),
  Income(
      2,
      Uuid().v4(),
      "2022-10-13",
      TimeOfDay.now().toString(),
      1000,
      "TPA - MCX",
      "Outros",
      1,
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now())),
  Income(
      3,
      Uuid().v4(),
      "2022-10-20",
      TimeOfDay.now().toString(),
      1000,
      "TTRF HBMB",
      "Outros",
      1,
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now())),
  Income(
      4,
      Uuid().v4(),
      "2022-10-05",
      TimeOfDay.now().toString(),
      1000,
      "TRB OR",
      "Outros",
      1,
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now())),
  Income(
      5,
      Uuid().v4(),
      "2022-10-01",
      TimeOfDay.now().toString(),
      30000,
      "ANATEL INDUSTRIA",
      "Outros",
      1,
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()))
];

List<CategoryModel> categorys = [
  CategoryModel(1, "", "", "Alimentacao", "#f5f5f5", "", 2000, "expense"),
  CategoryModel(2, "", "", "Transporte", "#ef5d4a9", "", 4000, "expense"),
];

Map<String, double> monthBalanceByCategory = {
  "Alimentacao": 4000,
  "Transporte": 2000,
};

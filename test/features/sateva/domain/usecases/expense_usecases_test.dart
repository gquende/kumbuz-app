import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/data/repositories/expense_repository.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/add_expense_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/delete_expense_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/update_expense_usecase.dart';

main() {
  late AppDatabase database;
  late ExpenseRepository repository;
  late DeleteExpenseUsecase deleteExpenseUsecase;
  late AddExpenseUsecase addExpenseUsecase;
  late UpdateExpenseUsecase updateExpenseUsecase;
  // late DeleteTransactionUsecase usecase;

  setUp(() async {
    database = await $FloorAppDatabase.databaseBuilder("app.db").build();
    repository = ExpenseRepository(database);
    deleteExpenseUsecase = DeleteExpenseUsecase(repository);
    addExpenseUsecase = AddExpenseUsecase(repository);
    updateExpenseUsecase = UpdateExpenseUsecase(repository);
  });

  test("Insert Expense", () async {
    Expense expense = Expense(0, "userId", "date", "time", 1000, "description",
        "category", 0, "createAt", "updateAt");

    var result = await repository.insert(expense);
    print("INSERT ITEM ID:: $result");
    expect(result > 0, true);
  });

  test(" Delete Expense", () async {
    Expense expense = Expense(0, "userId", "date", "time", 1000, "description",
        "category", 0, "createAt", "updateAt");

    var result = await repository.insert(expense);
    var testvalue = await deleteExpenseUsecase.handle(expense);
    print("DELETE ITEM ID:: $testvalue");

    expect(testvalue > 0, true);
  });

  test(" Update Expense", () async {
    Expense expense = Expense(0, "userId", "date", "time", 1000, "description",
        "category", 0, "createAt", "updateAt");

    var result = await repository.insert(expense);

    expense.description = "Actualizando dados";

    var testvalue = await updateExpenseUsecase.handle(expense);
    print("UPDATE ITEM ID:: $testvalue");

    expect(testvalue > 0, isTrue);
  });
}

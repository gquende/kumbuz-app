import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/data/models/income.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/data/repositories/expense_repository.dart';
import 'package:kumbuz/features/sateva/data/repositories/income_repository.dart';
import 'package:kumbuz/features/sateva/data/repositories/transaction_repository.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/add_expense_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/delete_expense_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/update_expense_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/income_usecases/add_income_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/income_usecases/delete_expense_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/income_usecases/update_expense_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/transactions_usecase/delete_transactions.dart';
import 'package:uuid/uuid.dart';

main() {
  late AppDatabase database;
  late IncomeRepository repository;
  late DeleteIncomeUsecase deleteExpenseUsecase;
  late AddIncomeUsecase addIncomeUsecase;
  late UpdateIncomeUsecase updateExpenseUsecase;
  // late DeleteTransactionUsecase usecase;

  setUp(() async {
    database = await $FloorAppDatabase.databaseBuilder("app.db").build();
    repository = IncomeRepository(database);
    deleteExpenseUsecase = DeleteIncomeUsecase(repository);
    addIncomeUsecase = AddIncomeUsecase(repository);
    updateExpenseUsecase = UpdateIncomeUsecase(repository);
  });

  test("Insert Income", () async {
    Income income = Income(0, "userId", "date", "time", 1000, "description",
        "category", 0, "createAt", "updateAt");

    var result = await repository.insert(income);
    print("INSERT ITEM ID:: $result");
    expect(result > 0, true);
  });

  test(" Delete Income", () async {
    Income expense = Income(0, "userId", "date", "time", 1000, "description",
        "category", 0, "createAt", "updateAt");

    var result = await repository.insert(expense);
    var testvalue = await deleteExpenseUsecase.handle(expense);
    print("DELETE ITEM ID:: $testvalue");

    expect(testvalue > 0, true);
  });

  test(" Update Income", () async {
    Income expense = Income(0, "userId", "date", "time", 1000, "description",
        "category", 0, "createAt", "updateAt");

    var result = await repository.insert(expense);

    expense.description = "Actualizando dados";

    var testvalue = await updateExpenseUsecase.handle(expense);
    print("UPDATE ITEM ID:: $testvalue");

    expect(testvalue > 0, isTrue);
  });
}

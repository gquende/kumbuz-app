import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/data/repositories/transaction_repository.dart';
import 'package:kumbuz/features/sateva/domain/usecases/transactions_usecase/delete_transactions.dart';
import 'package:uuid/uuid.dart';

main() {
  late AppDatabase database;
  late TransactionRepository repository;
  late DeleteTransactionUsecase usecase;
  // late DeleteTransactionUsecase usecase;

  setUp(() async {
    database = await $FloorAppDatabase.databaseBuilder("app.db").build();
    repository = await TransactionRepository(database);
    usecase = await DeleteTransactionUsecase(repository);
  });

  test("Insert", () async {
    WalletTransaction t = WalletTransaction(
        Uuid().v4(),
        "description",
        "walletId",
        "itemId",
        1000,
        "debt",
        "date",
        "time",
        "createAt",
        "updateAt");

    var result = await repository.insert(t: t);
    expect(result > 0, true);
  });

  test("Delete Debt", () async {
    WalletTransaction t = WalletTransaction(
        Uuid().v4(),
        "description",
        "walletId",
        "itemId",
        1000,
        "debt",
        "date",
        "time",
        "createAt",
        "updateAt");

    var result = await repository.insert(t: t);
    print("ITEM ID:: $result");
    var test = await usecase.handle(id: t.uuid);
    print("ITEM ID:: $test");

    expect(test > 0, true);
  });
}

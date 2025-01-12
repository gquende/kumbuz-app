import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:kumbuz/core/db/database.dart';

import 'package:kumbuz/features/sateva/data/models/income.dart';

main() {
  // test('Create Wallet', () {
  //   Wallet wallet =
  //       Wallet("1", "1", "Poupanca", 2000, false, "", "p", "#FFFFFF", []);
  //   expect(wallet != null, true);
  //   expect(wallet.id == "1", true);
  //   expect(wallet.amount == 2000, true);
  //   expect(wallet.name == "Poupanca", true);
  //   expect(wallet.excludeInTotal == false, true);
  //   expect(wallet.userId == "1", true);
  //   expect(wallet.iconUrl!.isEmpty == true, true);
  //   expect(wallet.type == "p", true);
  //   expect(wallet.color.isNotEmpty == true, true);
  // });
  //
  // test("Add New User Wallet", () async {
  //   WalletController controller = WalletController({});
  //   Wallet wallet =
  //       Wallet("1", "1", "Poupanca", 2000, false, "", "p", "#FFFFFF", []);
  //   await controller.addWallet(wallet);
  //   // expect(await controller.addWallet(wallet) == true, true);
  //   // expect(controller.userWallets.length > 0, true);
  // });

  test("Insert on DataBase", () async {
    AppDatabase? db = await $FloorAppDatabase.databaseBuilder('app.db').build();
    Income novo = Income(0, "Teste", "Test", "ede", 2000, "Testte", "Etrye", 1,
        DateTime.now().toString(), DateTime.now().toString());
    int valor = await db.incomeDao.insertItem(novo);
    print(valor);
  });

  test("Get All Incomes", () async {
    AppDatabase? db = await $FloorAppDatabase.databaseBuilder('app.db').build();
    List<Income> incomes = await db.incomeDao.getAll();
    incomes.forEach((element) {
      print(element.toString());
    });

    expect(incomes.length > 0, true);
  });
//
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/setup_app.dart';
import 'package:kumbuz/features/open_finance/domain/entity/bank_entity.dart';
import 'package:kumbuz/features/open_finance/presenter/controllers/bank_controller.dart';
import 'package:kumbuz/features/sateva/data/models/user.dart';
import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:kumbuz/services/nordigen_service.dart';

void main() {
  BankController? controller;
  NordigenClient? apiClient;
  User? user;
  Wallet? wallet;

  setUp(() async {
    apiClient = NordigenClient(
        secret_id: "59d4b4da-e20d-434f-837c-157838b0a7a3",
        secret_key:
            "bd8759daa1d0618a6a4c889c3ce8ad045790fd7df70bb6808f45a79ff0f25812cac4dca8a748131cd0e42acdb465c0a3d8ca2e58d8dad00e9a2f5355a67854f7");
    // apiClient=NordigenClient(secret_id: , secret_key: secret_key)
    // controller = BankAgreement(apiC);
    controller = BankController(apiClient!, "SANDBOXFINANCE_SFIN0000");

    user = User(0, "firebase", "Adolfo", "Quende", "gquende@meukumbu.com",
        "adolfo", "Perfil Financeiro", "test", "Test");
    wallet = Wallet(1, user!.uuId, "Base", 234, false, "", "base", "",
        DateTime.now().toString(), DateTime.now().toString());
    await setupApp();
  });

  test("Get Access Token", () async {
    var token = await controller!.generateToken();
    //print("TOKEN: $token");
    expect(token, isNotNull);
  });

  test("List Bank", () async {
    List<Bank>? banks = await controller!.getBanks("gb");
    expect(banks, isNotEmpty);
    expect(banks!.length > 10, true);
  });

  test("Get Agreemeent", () async {
    var agreement = await controller!.createAgreement(maxHistoricalDays: 90);
    expect(agreement, isNotNull);
    print(agreement!.id);
  });

  test("Get connect account", () async {
    var metadata = await controller!.connectAccount("Test");
    debugPrint(jsonEncode(metadata));
    expect(metadata, isNotNull);
  });

  test("Get Account details", () async {
    var accountDetails = await controller!
        .getAccountDetails("7e944232-bda9-40bc-b784-660c7ab5fe78");
    accountDetails!.forEach((key, value) {
      debugPrint(jsonEncode(value));
    });
    expect(accountDetails, isNotNull);
  });

  test("Get Account Balances", () async {
    var accountDetails = await controller!
        .getAccountBalances("7e944232-bda9-40bc-b784-660c7ab5fe78");
    // accountDetails!.forEach((key) {
    //   debugPrint(jsonEncode(key));
    // });

    debugPrint(jsonEncode(accountDetails));

    expect(accountDetails, isNotNull);
  });

  test("Get Account Transaction", () async {
    var accountDetails = await controller!
        .getAccountTransactions("7e944232-bda9-40bc-b784-660c7ab5fe78");
    // accountDetails!.forEach((key, value) {
    //   debugPrint(jsonEncode(value));
    // });
    expect(accountDetails, isNotNull);
  });
  test("Save BankAccount", () async {
    await controller!.connectAccount("");
    await controller!.saveBankAccount(user!, Bank("", "BFA", "TEDT", "DEDE"));
  });
}

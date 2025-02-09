import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/services/nordigen_service.dart';

void main() {
  NordigenClient? client;

  setUp(() async {
    client = NordigenClient(
        secret_id: "4a51eb77-4780-40c0-a63b-dc4b890f768",
        secret_key:
            "06fab633649e2fe682eb56aac23d9996fcedb4e353c41e2ceb4865530901549bfb9121b9cb4287a8a50ea3263ae0dc9870cb6be06394cfa7e299c40dbe1ba82");
  });

  test("GET ACCESS TOKEN", () async {
    print(jsonEncode(await client!.generateToken()));
  });

  test("Get Account", () async {
    AccountApi accountApi = await client!
        .account(accountId: "7e944232-bda9-40bc-b784-660c7ab5fe78");
    print(jsonEncode(await accountApi.getDetails()));
  });

  test("Get Ageement", () async {
    var agreement = await client!.agreement!.createAgreement(
        institutionId: "SANDBOXFINANCE_SFIN0000", maxHistoricalDays: 90);
    print("This is agreement Id: ${agreement.id}");
  });

  test("Init Session", () async {
    var map = await client!.initSession(
      redirectUrl: "https://www.google.com",
      institutionId: "SANDBOXFINANCE_SFIN0000",
    );

    //4c135945-60cc-4f62-8895-9e34cdfd9072
    //"accounts":["7e944232-bda9-40bc-b784-660c7ab5fe78","99a0bfe2-0bef-46df-bff2-e9ae0c6c5838"]
    print(jsonEncode(map));

    var bankAccounts = map['results'] as List;
    bankAccounts.forEach((element) {
      if ((element['accounts'] as List).length > 1) print(jsonEncode(element));
    });

    // print(jsonEncode(map['results']));

    expect(map, isNotNull);
  });
}

//GL3343697694912188
//GL0865354374424724
//1e2d5b1e-2e3c-4ed1-bfb3-3cf9641df7fe
//1e2d5b1e-2e3c-4ed1-bfb3-3cf9641df7fe

import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/services/mhadia_service.dart';

main() {
  MhadiaService? service;

  setUp(() {
    service = MhadiaService(base_url: "http://127.0.0.1:5000");
  });

  test("Get Data", () async {
    var test = await service!.request(
        endpoint: "budget/predict",
        parameters: {
          "date": "amount",
          "2012-07-25": "82.55",
          "2012-12-10": "61.01",
          "2013-02-19": "11.54",
          "2013-02-24": "66.67",
          "2013-04-20": "7.99",
          "2013-04-25": "7.99",
          "2013-07-08": "84.59",
        },
        method: "POST");
    // print(jsonEncode(test));

    var yhat = (test as Map)["yhat"];
    print(double.parse("${(yhat as Map).values.last}").round());

    expect(test, isNotNull);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';

void main() {
  test("Get Date Of First Day of the Month", () {
    expect(
        DateTimeManipulation.getDateOfTheFirstDayOfMonth(DateTime.now()) ==
            "2022-05-01",
        true);
  });

  test("Get Date Of Last Day of the Month", () {
    expect(
        DateTimeManipulation.getDateOfTheLastDayOfMonth(DateTime.now()) ==
            "2022-05-31",
        true);
  });

  test("Get Date Of Previous Month", () {
    expect(
        DateTimeManipulation.getDateOfPreviousMonth(DateTime.now()) ==
            "2022-04-01",
        true);
  });

  test("Get Date Of Forward Month", () {
    expect(
        DateTimeManipulation.getDateOfFowardMonth(DateTime.now()) ==
            "2022-06-01",
        true);
  });

  test("Get date from datetime formated", () async {
    DateTime newDate = DateTimeManipulation.getDate("2022-02-01");
    expect(
        newDate.day == 1 && newDate.month == 2 && newDate.year == 2022, true);
    // expect(newDate.month ==1, 1);
  });
}
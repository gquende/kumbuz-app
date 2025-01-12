import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/features/sateva/domain/entities/income2.dart';
import 'package:kumbuz/features/sateva/domain/repositories/income_repository.dart';
import 'package:kumbuz/features/sateva/domain/usecases/income_controller2.dart';
import 'package:mockito/mockito.dart';

class MockIncomeRepository extends Mock implements IncomeRepository {}

void main() {
  IncomeController2? incomeController2;
  MockIncomeRepository? repository;

  setUp(() {
    repository = MockIncomeRepository();
    incomeController2 = IncomeController2(incomeRepository: repository!);
  });

  final Income2 income2 = Income2(id: 1, description: "Description Test");

  test("Test de IncomeController", () async {
    when(repository!.getIncomeById(1)).thenAnswer((_) async => income2);

    final result = await incomeController2!.getIncomeById(1);
    expect(income2, result);
    verify(repository!.getIncomeById(1));
    verifyNoMoreInteractions(repository!.getIncomeById(1));
  });
}

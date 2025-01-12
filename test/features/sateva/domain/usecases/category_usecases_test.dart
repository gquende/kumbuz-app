import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/models/category_model.dart';
import 'package:kumbuz/features/sateva/domain/repositories/category_repository.dart';
import 'package:kumbuz/features/sateva/domain/usecases/category_usecases.dart';
import 'package:mockito/mockito.dart';

class MockCategoryImplementation extends Mock implements CategoryRepository {}

void main() {
  CategoryRepository repository;
  CategoryUsecases? categoryUsecases;
  AppDatabase database;

  setUp(() async {
    database = await $FloorAppDatabase.databaseBuilder("app.db").build();
    repository = MockCategoryImplementation();
    categoryUsecases = CategoryUsecases(database);
  });

  test("Insert A Category", () async {
    var random = Random(200);
    var id = random.nextInt(200);
    id = 4;
    CategoryModel novo =
        CategoryModel(id, "e", "Nova", "Teste", "UE", "ER", 0990, "expense");

    var value = await categoryUsecases!.insertCategory(novo);
    expect(value, equals(4));
  });

  test("Delete Category", () async {
    var random = Random(200);
    CategoryModel novo = CategoryModel(
        random.nextInt(200), "e", "Nova", "Teste", "UE", "ER", 880, "expense");
    CategoryModel novo2 = CategoryModel(
        random.nextInt(200), "e", "Nova", "Teste", "UE", "ER", 0990, "expense");
    var value = await categoryUsecases!.insertCategory(novo);
    var isDeleted = await categoryUsecases!.deleteItem(novo);
    expect(isDeleted, equals(1));
    isDeleted = await categoryUsecases!.deleteItem(novo2);
    expect(isDeleted, equals(0));
  });

  test("Update Category", () async {
    var random = Random(200);
    CategoryModel novo = CategoryModel(
        random.nextInt(200), "e", "Nova", "Teste", "UE", "ER", 6768, "expense");
    CategoryModel novo2 = CategoryModel(
        random.nextInt(200), "e", "Nova", "Teste", "UE", "ER", 8080, "expense");
    var value = await categoryUsecases!.insertCategory(novo);
    novo.name = "Alimentation";
    var isDeleted = await categoryUsecases!.updateItem(novo);
    expect(isDeleted, equals(1));
    isDeleted = await categoryUsecases!.updateItem(novo2);
    expect(isDeleted, equals(0));
  });

  test("Get Category", () async {
    var random = Random(200);

    CategoryModel novo =
        CategoryModel(202, "e", "Nova", "Teste", "UE", "ER", 808, "expense");
    //var value = await categoryUsecases!.insertCategory(novo);
    // CategoryModel novo2 =
    CategoryModel(
        random.nextInt(200), "e", "Nova", "Teste", "UE", "ER", 9090, "expense");
    CategoryModel? model = await categoryUsecases!.getCategoryByID(novo.id);
    expect(model, novo);
  });
}

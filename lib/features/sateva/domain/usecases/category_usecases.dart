import 'package:flutter/cupertino.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/models/category_model.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';

class CategoryUsecases with ChangeNotifier {
  AppDatabase _database;
  //CategoryRepository _categoryRepository;
  CategoryUsecases(this._database);

  Future<CategoryModel?> getCategoryByID(int id) async {
    var value = await _database.categoryDao.getById(id);
    return value;
  }

  Future<int?> insertCategory(CategoryModel item) async {
    var id = await _database.categoryDao.insertItem(item);
    notifyListeners();
    return id;
  }

  Future<int> updateItem(CategoryModel item) async {
    var id = await _database.categoryDao.updateItem(item);
    notifyListeners();
    return id;
  }

  Future<int> deleteItem(CategoryModel item) async {
    var id = await _database.categoryDao.deleteItem(item);
    notifyListeners();
    return id;
  }

  Future<List<Category>?> getAllCategory() async {
    try {
      var data = await _database.categoryDao.getAllCategories();

      print(data);

      return data;
    } catch (error) {
      debugPrint("Erro: ${error.toString()}");
    }
  }

  Future<List<Category>?> getAllCategoryByType(String type) async {
    try {
      return await _database.categoryDao.getAllCategoriesByType(type);
    } catch (error) {
      debugPrint("Erro: ${error.toString()}");
    }
  }
}

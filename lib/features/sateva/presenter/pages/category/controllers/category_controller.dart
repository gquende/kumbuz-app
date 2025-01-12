import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/data/models/category_model.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';

import '../../../../domain/usecases/category_usecases.dart';

class CategoryController extends GetxController {
  late AnimationController animationController;
  late PageController pageController = PageController();
  late Animation<double> rotation;

  Future<List<Category>> getAll({String type = ""}) async {
    try {
      var usecase = DI.get<CategoryUsecases>();

      if (type.isEmpty) {
        return await usecase.getAllCategory() ?? [];
      }

      return await usecase.getAllCategoryByType(type) ?? [];
    } catch (error) {}

    return [];
  }

  Future<int?> addCategory(CategoryModel category) async {
    try {
      var usecase = DI.get<CategoryUsecases>();

      return await usecase.insertCategory(category);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<int?> deleteCategory(CategoryModel category) async {
    try {
      var usecase = DI.get<CategoryUsecases>();

      return await usecase.deleteItem(category);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<int?> updateCategory(CategoryModel category) async {
    try {
      var usecase = DI.get<CategoryUsecases>();

      return await usecase.updateItem(category);
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

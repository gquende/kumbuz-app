import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';

abstract class CategoryRepository<Table extends Category> {
  @insert
  Future<int> insertItem(Table item);
  @update
  Future<int> updateItem(Table item);
  @delete
  Future<int> deleteItem(Table item);
  @Query("SELECT * FROM categories WHERE id= :id")
  Future<Table?> getById(int id);

  @Query("SELECT * FROM categories")
  Future<List<Table>?> getAllCategories();

  @Query("SELECT * FROM categories WHERE type= :type")
  Future<List<Table>?> getAllCategoriesByType(String type);
}

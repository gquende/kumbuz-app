import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/category_model.dart';
import 'package:kumbuz/features/sateva/domain/repositories/category_repository.dart';

@dao
abstract class CategoryImpl extends CategoryRepository<CategoryModel> {}
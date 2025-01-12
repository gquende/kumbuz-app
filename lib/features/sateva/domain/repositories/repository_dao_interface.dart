import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/domain/entities/entity_base.dart';

abstract class IRepositoryDaoInterface<Table extends EntityBase> {
  @insert
  Future<int> insertItem(Table item);
  @update
  Future<int> updateItem(Table item);
  @delete
  Future<int> deleteItem(Table item);
}
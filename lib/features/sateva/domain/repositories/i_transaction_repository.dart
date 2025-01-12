import 'package:kumbuz/features/sateva/domain/entities/transaction_entity.dart';

abstract class ITransactionRepository<T extends TransactionEntity> {
  Future<List<T>> getAll({String startDate = "", String endDate = ""});
  Future<dynamic> update(T t);
  Future<List<T>> getAllByType(
      {String type, String startDate = "", String endDate = ""});

  Future<List<T>> getAllByTypeAndItemID(
      {required String type,
      required String itemId,
      String startDate = "",
      String endDate = ""});

  Future<double?> getSumByType(
      {String type, String startDate = "", String endDate = ""});
  Future<List<T>> getByDescription({required String description});
  Future<int> delete({required String id});
  Future<int> insert({required T t});
}

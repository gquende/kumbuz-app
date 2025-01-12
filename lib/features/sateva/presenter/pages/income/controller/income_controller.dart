import 'package:flutter/cupertino.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/features/sateva/domain/usecases/income_usecases/update_expense_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/transactions_usecase/update_transaction_usecase.dart';

import '../../../../data/models/income.dart';
import '../../../../domain/entities/transaction_entity.dart';

class IncomeController extends ChangeNotifier {
  Future<void> updateIncome(
      {required Income income,
      required TransactionEntity transaction,
      BuildContext? context}) async {
    try {
      await DI.get<UpdateIncomeUsecase>().handle(income);
      await DI.get<UpdateTransactionUsecase>().handle(transaction: transaction);
      notifyListeners();
    } catch (error, stackTrace) {
      errorLog(error, stackTrace);
    }
  }
}

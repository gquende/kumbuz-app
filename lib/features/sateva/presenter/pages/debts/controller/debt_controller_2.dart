import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/data/models/debt.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/domain/usecases/debt_usecases/create_debt_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/debts_usecases.dart';
import 'package:provider/provider.dart';
import '../../../../domain/usecases/controllers/wallet_ controller.dart';

class DebtController extends ChangeNotifier {
  Future<int> createDebt(Debt debt, BuildContext context) async {
    try {
      notifyListeners();

      var result = await DI.get<CreateDebtUsecase>().handle(debt);

      if (result != null && result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Dívida registada!"),
          backgroundColor: Colors.greenAccent,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Erro ao tentar registar!"),
          backgroundColor: Colors.redAccent,
        ));
      }
    } catch (error) {
      log("DebtController2:: CreateDebt:: ${error.toString()}");
    }

    return 0;
  }

  Future<int> registeTransaction(
      {required WalletTransaction transaction,
      required Debt debt,
      required BuildContext context}) async {
    try {
      debt.amount = debt.amount + double.parse("${transaction.amount}");
      if (debt.amount >= debt.amountTarget) {
        debugPrint("Dívida fechada!");
        debt.amount = debt.amountTarget;
        debt.isDone = true;
      }
      debt.percentDone = (debt.amount / debt.amountTarget) * 100;

      context.read<WalletController>().addWalletTransaction(transaction);
      await context.read<DebtsUsecases>().updateDebt(debt);

      if (debt.percentDone! >= 100) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Dívida Fechada!"),
          backgroundColor: Colors.green,
        ));
      }

      print("DEBT DATA::");
      print(debt.toString());
      notifyListeners();
      return 1;
    } catch (error) {
      log("DebtController2:: RegisteTransaction:: ${error.toString()}");
    }
    return 0;
  }

  Future<List<Debt>> getDebtNotDoneByType(
      {required int status, required BuildContext context}) async {
    try {
      var data = await context.read<DebtsUsecases>().getDebtsNotDone() ?? [];

      if (status == 1) {
        return data.where((value) => value.to.isNotEmpty).toList();
      } else if (status == 2) {
        return data.where((value) => value.from.isNotEmpty).toList();
      }
      return [];
    } catch (error) {
      log("DebtController:: GetDebtNotDoneByType ${error.toString()}");
    }

    return [];
  }

  Future<double> getSumDebtNotDoneByType(
      {required int status, required BuildContext context}) async {
    try {
      var data = await context.read<DebtsUsecases>().getDebtsNotDone() ?? [];

      if (status == 1) {
        var sumValue = 0.0;

        data.where((value) => value.to.isNotEmpty).toList().forEach((action) {
          sumValue += action.amountTarget - action.amount;
        });

        return sumValue;
      } else if (status == 2) {
        var sumValue = 0.0;
        data.where((value) => value.from.isNotEmpty).toList().forEach((action) {
          sumValue += action.amountTarget - action.amount;
        });

        return sumValue;
      }
      return 0.0;
    } catch (error) {
      log("DebtController:: GetDebtNotDoneByType ${error.toString()}");
    }

    return 0.0;
  }
}

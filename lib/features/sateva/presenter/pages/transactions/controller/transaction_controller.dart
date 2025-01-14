import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/data/models/income.dart';
import 'package:kumbuz/features/sateva/domain/entities/transaction_entity.dart';
import 'package:kumbuz/features/sateva/domain/usecases/expense_usecase/get_expense_by_id_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/transactions_usecase/delete_transactions.dart';

import '../../../../../../shared/presentation/ui/spacing.dart';
import '../../../../data/models/expense.dart';
import '../../../../domain/repositories/i_transaction_repository.dart';
import '../../../../domain/usecases/expense_usecase/delete_expense_usecase.dart';
import '../../../../domain/usecases/income_usecases/delete_expense_usecase.dart';
import '../../../../domain/usecases/income_usecases/get_income_by_id_usecase.dart';

class TransactionController extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  var transactions = <TransactionEntity>[].obs;
  var _startDate = "".obs;
  var _endDate = "".obs;

  TransactionController() {
    _startDate.value =
        DateTimeManipulation.getDateOfTheFirstDayOfMonth(DateTime.now());
    _endDate.value =
        DateTimeManipulation.getDateOfTheLastDayOfMonth(DateTime.now());

    filter();
  }

  Future<dynamic> filter() async {
    try {
      transactions.value = await DI
          .get<ITransactionRepository>()
          .getAll(startDate: _startDate.value, endDate: _endDate.value);
    } catch (error) {
      debugPrint("TransactionController:: Filter:: ${error.toString()}");
    }
  }

  Future<int> delete(TransactionEntity transaction) async {
    try {
      var result =
          await DI.get<DeleteTransactionUsecase>().handle(id: transaction.uuid);

      if (result > 0) {
        switch (transaction.type) {
          case "income":
            {
              var income = Income(0, "", "", "", 0, "", "", 0, "", "");
              income.uuId = transaction.itemId;
              DI.get<DeleteIncomeUsecase>().handle(income);
            }
            break;
          case "expense":
            {
              var expense = Expense(0, "", "", "", 0, "", "", 0, "", "");
              expense.uuId = transaction.itemId;
              DI.get<DeleteExpenseUsecase>().handle(expense);
            }
            break;
        }
      }

      notifyListeners();
      return result;
    } catch (error) {
      debugPrint("TransactionController:: Filter:: ${error.toString()}");
    }

    notifyListeners();
    return 0;
  }

  Future<void> filterTransaction(BuildContext context) async {
    var size = MediaQuery.of(context).size;
    var isLoading = false.obs;

    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Data início"),
                              const SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var date = await _seleccionarData(context);

                                  if (date.isNotEmpty) {
                                    _startDate.value = date;
                                  }
                                },
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Color(0xfff5f5f5),
                                      borderRadius: BorderRadius.circular(8)),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.date_range,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Obx(() {
                                          return Text(_startDate.value);
                                        })
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Data Fim"),
                              const SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var date = await _seleccionarData(context);

                                  if (date.isNotEmpty) {
                                    _endDate.value = date;
                                  }
                                },
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                      color: Color(0xfff5f5f5),
                                      borderRadius: BorderRadius.circular(8)),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.date_range,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Obx(() {
                                            return Text(_endDate.value);
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Spacing.y(),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              GestureDetector(
                                onTap: () async {
                                  isLoading.value = true;
                                  await filter();
                                  isLoading.value = false;

                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    width: size.width,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(0, 0),
                                              color: Colors.black12,
                                              spreadRadius: .7,
                                              blurRadius: 2)
                                        ],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Obx(() {
                                      return Center(
                                        child: isLoading.value
                                            ? const CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.white),
                                              )
                                            : const Text(
                                                "Filtrar",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                      );
                                    })),
                              ),
                            ],
                          )))),
            ),
          );
        },
        barrierDismissible: !isLoading.value);

    return;
  }

  Future<String> _seleccionarData(BuildContext context) async {
    var picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now().add(Duration(days: 60)),
    );

    if (picked != null && picked != DateTime.now()) {
      return picked.toLocal().toString().substring(0, 10);
    }
    return "";
  }

  Future<void> search() async {
    try {
      var repository = DI.get<ITransactionRepository>();

      if (searchController.text.isNotEmpty) {
        transactions.value = await repository.getByDescription(
            description: searchController.text);
      } else {
        filter();
      }
    } catch (error) {
      debugPrint("SEARCH ERROR:: ${error.toString()}");
    }
  }

  Future<void> dispose() async {
    searchController.text = "";
    _startDate.value =
        DateTimeManipulation.getDateOfTheFirstDayOfMonth(DateTime.now());
    _endDate.value =
        DateTimeManipulation.getDateOfTheLastDayOfMonth(DateTime.now());

    filter();
  }

  Future<Object?> getTransactionData(
      TransactionEntity transaction, Object? data) async {
    switch (transaction.type) {
      case "expense":
        {
          return await DI
              .get<GetExpenseByIDUsecase>()
              .handle(uuid: transaction.itemId);
        }
        break;
      case "income":
        {
          print("Transaction Income:: $transaction");
          var data = await DI
              .get<GetIncomeByIDUsecase>()
              .handle(uuid: transaction.itemId);

          print("DATA:: $data");

          return data;
        }
        break;
      case "debt":
        {}
        break;
      case "goal":
        {}
        break;
    }
    return null;
  }
}

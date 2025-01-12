import 'package:flutter/material.dart';
import 'package:kumbuz/configs/theme/styles.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/core/utils/currency_utils.dart';
import 'package:kumbuz/features/sateva/domain/entities/transaction_entity.dart';
import 'package:kumbuz/features/sateva/domain/usecases/transactions_usecase/delete_transactions.dart';
import 'package:kumbuz/features/sateva/presenter/pages/expense/add_expense.dart';
import 'package:kumbuz/features/sateva/presenter/pages/expense/controller/expense_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/income/income_form.dart';
import 'package:kumbuz/features/sateva/presenter/pages/transactions/controller/transaction_controller.dart';
import 'package:kumbuz/shared/presentation/ui/spacing.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/wiiget_utils.dart';
import '../../../data/models/expense.dart';
import '../../../data/models/income.dart';
import '../../../data/models/wallet_transaction.dart';
import '../../../domain/usecases/controllers/wallet_ controller.dart';

class TransactionDetails extends StatefulWidget {
  TransactionEntity transaction;

  TransactionDetails({required this.transaction});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  late final TransactionController controller;
  Object? data;
  bool isDeleted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = context.read<TransactionController>();
    setData();
  }

  Future<void> setData() async {
    data = await controller.getTransactionData(widget.transaction, data);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Detalhes da transacção",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            // backgroundColor: Theme.of(context).primaryColor,

            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        print("Editing...");

                        if (data is Expense) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (builder) => AddExpense(
                                        expense: data as Expense,
                                        transaction: widget.transaction,
                                      )));
                        } else if (data is Income) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (builder) => IncomeForm(
                                        income: data as Income,
                                        transaction: widget.transaction,
                                      )));
                        }
                      },
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        if (await _showDeleteDialog(context)) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.3,
                  decoration: AppStyles.containerDecoration(context),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: setIcon(widget.transaction.type),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: setColor(widget.transaction.type)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.transaction.description,
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.category,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              setText(widget.transaction.type),
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on_rounded,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              currencyFormatUtils(widget.transaction.amount),
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.transaction.date,
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.transaction.time,
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<bool> _showDeleteDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          title: Text("Confirmação"),
          content: Text("Tem certeza que quer eliminar este item?"),
          actions: [
            TextButton(
              child: Text("Não"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
            ),
            TextButton(
              child: Text("Sim"),
              onPressed: () async {
                var data = await controller.delete(widget.transaction);

                if (data > 0) {
                  isDeleted = true;
                }
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed != null && confirmed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Item eliminado com sucesso"),
            backgroundColor: Colors.green,
          ),
        );

        return true;
      }
      return false;
    });
  }
}

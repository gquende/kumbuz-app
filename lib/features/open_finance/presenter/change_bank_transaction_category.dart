import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/data/models/category_model.dart';
import 'package:kumbuz/features/sateva/presenter/pages/base/pages/root_app.dart';
import 'package:kumbuz/features/sateva/presenter/widget/day_transaction_with_category.dart';

import '../../../configs/config.dart';
import '../../../core/setup_app.dart';
import 'controllers/bank_controller.dart';

class ChangeCategoryOfBankTransaction extends StatefulWidget {
  const ChangeCategoryOfBankTransaction({Key? key}) : super(key: key);

  @override
  State<ChangeCategoryOfBankTransaction> createState() =>
      _ChangeCategoryOfBankTransactionState();
}

class _ChangeCategoryOfBankTransactionState
    extends State<ChangeCategoryOfBankTransaction> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmar categoria"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Confirme as categorias das suas últimas transacções bancárias",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: size.height * 0.70,
            width: size.width,
            child: ListView(
              children: BankController.bankTransactions.map((e) {
                if (e.type == "expense") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DayTransactionWithCategory(
                      transaction: e,
                      categories: mockCategories,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DayTransactionWithCategory(
                    transaction: e,
                    categories: mockCategories,
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: AppColors.primaryColor),
              height: 56,
              //color: menuColor,
              child: SizedBox.expand(
                child: TextButton(
                    onPressed: () async {
                      print('Get Bank Acoount...');
                      //setLoading();
                      /* await _bankController.saveBankAccount(
                                    App.user, widget.bank,
                                    accountId: accountsName.first);
                                setLoading();
                       */

                      await locator<BankController>().save();

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Conta adicionada!"),
                        backgroundColor: Colors.green,
                      ));

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RootApp()));
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kumbuz/configs/assets.dart';
import 'package:kumbuz/features/open_finance/presenter/add_bank_account.dart';
import 'package:kumbuz/features/open_finance/presenter/controllers/bank_controller.dart';
import 'package:kumbuz/features/open_finance/presenter/widgets/bank_account_card.dart';

import '../../../app.dart';
import '../../../core/di/dependecy_injection.dart';

class BankAccountsPage extends StatefulWidget {
  const BankAccountsPage({super.key});

  @override
  State<BankAccountsPage> createState() => _BankAccountsPagenState();
}

class _BankAccountsPagenState extends State<BankAccountsPage> {
  var controller = DI.get<BankController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas bancárias"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
                future: controller.getRegisterBanks(App.user?.uuId ?? ""),
                builder: (_, snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: Text("Sem Dados!!"),
                    );
                  }

                  if ((snap.data ?? []).isEmpty) {
                    return Container(
                      height: size.height * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(AppAssets.CREDIT_CARD),
                            width: 300,
                          ),
                          const Wrap(
                            children: [
                              Text(
                                "Adicione uma conta bancária e rastreie o seus gastos de forma automatizada",
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: (snap.data ?? []).map((element) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: BankAccountCard(bank: element),
                      );
                    }).toList(),
                  );
                })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddBankAccount()));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

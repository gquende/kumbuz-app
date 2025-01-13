import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/game_icons.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/data/models/debt.dart';
import 'package:kumbuz/features/sateva/presenter/pages/debts/controller/debt_controller_2.dart';
import 'package:kumbuz/features/sateva/presenter/widget/day_transaction_widget.dart';
import 'package:kumbuz/features/sateva/presenter/widget/debt_card.dart';
import 'package:provider/provider.dart';

import '../../../domain/usecases/transactions_usecase/get_transactions_by_type_item.dart';
import 'add_debt_transaction.dart';

class DebtDetails extends StatefulWidget {
  Debt debt;

  DebtDetails({required this.debt});

  @override
  State<DebtDetails> createState() => _DebtDetailsState();
}

class _DebtDetailsState extends State<DebtDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    context.watch<DebtController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.debt.from.isEmpty
            ? "Dívida ${widget.debt.type.toLowerCase()} à ${widget.debt.to}"
            : "Dívida ${widget.debt.type.toLowerCase()} à ${widget.debt.from}"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: DebtCard(debt: widget.debt, navigation: false),
          ),
          Positioned(
              top: size.height * 0.22,
              child: Container(
                height: size.height * 0.66,
                child: FutureBuilder(
                    future: DI
                        .get<GetTransactionsByTypeItem>()
                        .handle(type: "debt", itemId: widget.debt.uuid),
                    builder: (c, snap) {
                      if (!snap.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var data = snap.data ?? [];

                      if (data.isNotEmpty) {
                        return SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Pagamentos"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: data.map((element) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: DayTransactionWidget(
                                          transaction: element),
                                    );
                                  }).toList(),
                                )
                              ]),
                        );
                      }

                      return Container(
                        width: size.width,
                        child: Center(
                          child: Text("Sem registo de pagamentos"),
                        ),
                      );
                    }),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => AddDebtTransaction(debt: widget.debt)));
          },
          child: widget.debt.from.isEmpty
              ? const Iconify(
                  GameIcons.take_my_money,
                  size: 36,
                  color: Colors.white,
                )
              : const Iconify(
                  GameIcons.receive_money,
                  size: 36,
                  color: Colors.white,
                )),
    );
  }
}

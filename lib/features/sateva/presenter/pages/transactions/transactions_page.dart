import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/presenter/pages/transactions/controller/transaction_controller.dart';
import 'package:kumbuz/shared/presentation/ui/widgets/notification_icon.dart';

import '../../../../../configs/assets.dart';
import '../../widget/day_transaction_widget.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TransactionController _controller = DI.get<TransactionController>();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
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
            centerTitle: true,
            title: Text("Transacções"),
            actions: [NotificationIcon()],
          ),
          body: SizedBox(
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.85,
                            decoration: BoxDecoration(
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(8)),
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controller.searchController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.search),
                                    hintText: "Pesquisar",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: -2)),
                                keyboardType: TextInputType.url,
                                onChanged: (value) {
                                  Future.delayed(Duration(milliseconds: 500))
                                      .then((value) {
                                    _controller.search();
                                  });
                                },
                                onSubmitted: (value) => _controller.search(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                              onTap: () async {
                                await _controller.filterTransaction(context);
                              },
                              child: const Icon(Icons.filter_list)),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return SizedBox(
                          height: size.height * 0.8,
                          child: _controller.transactions.isNotEmpty
                              ? SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                        _controller.transactions.length,
                                        (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: DayTransactionWidget(
                                            transaction:
                                                _controller.transactions[index]
                                                    as WalletTransaction),
                                      );
                                    }),
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: size.width,
                                      child: Center(
                                        child: Image(
                                          image: AssetImage(
                                              AppAssets.NoTransactions),
                                          width: size.width * 0.45,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Sem transacções",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    )
                                  ],
                                ),
                        );
                      })
                    ],
                  ),
                ),
              ))),
    );
  }
}

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/wallet_%20controller.dart';
import 'package:kumbuz/features/sateva/presenter/widget/day_transaction_widget.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/dependecy_injection.dart';
import '../../../../services/firebase_messagin_service.dart';
import '../../../../services/notification_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WalletTransaction> transactions = [];
  CurrencyFormatterSettings aoaSettings = const CurrencyFormatterSettings(
    symbol: 'AOA',
    symbolSide: SymbolSide.right,
    thousandSeparator: ' ',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    initializeFirebaseMessaging();
    checkNotifications();
  }

  initializeFirebaseMessaging() async {
    await DI.get<FirebaseMessagingService>().initialize();
  }

  checkNotifications() async {
    await DI.get<NotificationService>().checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    //return Container();

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5f5),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Saldo",
                      style: TextStyle(color: Colors.white),
                    ),
                    Consumer<WalletController>(
                      builder: (_, _controller, child) {
                        return FutureBuilder(
                            //Todo Alterar para trazer o total de todas as carteiras
                            future: _controller.getSumOfAllWallet(),
                            builder: (context, snap) {
                              // debugPrint("This Wallet ID: ${}")
                              if (!snap.hasData) {
                                return CircularProgressIndicator();
                              }
                              return Text(
                                "${CurrencyFormatter.format(snap.data, aoaSettings)}",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              );
                            });
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Container()
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 15),
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rendimentos",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width / 30),
                          ),
                          Consumer<WalletController>(
                            builder: (_, _controller, child) {
                              return FutureBuilder(
                                future:
                                    _controller.getTotalAmountIncomesOfMonth(
                                        DateTimeManipulation
                                            .getYearAndMonthForSQliteFormat(
                                                DateTime.now())),
                                builder: (BuildContext context,
                                    AsyncSnapshot<double?> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text(
                                      "0 Kzs",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              30),
                                    );
                                  }
                                  return Text(
                                    "${CurrencyFormatter.format(snapshot.data, aoaSettings)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                30),
                                  );
                                },
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 15),
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: Colors.pinkAccent,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Despesas",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width / 30),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Últimas Actividades",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<WalletController>(
              builder: (_, _controller, child) {
                return FutureBuilder(
                    future: _controller.getTransactions(),
                    builder: (_, snap) {
                      if (!snap.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      transactions = snap.data as List<WalletTransaction>;
                      if (transactions.length > 0) {
                        return Column(
                          children: List.generate(
                              transactions.length > 6 ? 6 : transactions.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: DayTransactionWidget(
                                  transaction: transactions[index]),
                            );
                          }),
                        );

                        // return Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   height: MediaQuery.of(context).size.height / 2,
                        //   child: ListView.builder(
                        //       itemCount: transactions.length,
                        //       itemBuilder: (ctx, index) {
                        //         return Padding(
                        //           padding: const EdgeInsets.only(bottom: 8.0),
                        //           child: DayTransactionWidget(
                        //               transaction: transactions[index]),
                        //         );
                        //       }),
                        // );
                      }
                      return Container();
                    });
              },
            )

            // DayTransactionWidget(
            //     transaction: WalletTransaction(
            //         "uuid",
            //         "${App.wallet!.id2}",
            //         "wer",
            //         2000,
            //         "Income",
            //         DateTime.now().toLocal().toString(),
            //         TimeOfDay.now().toString(),
            //         DateTime.now().toString(),
            //         DateTime.now().toString())),
          ],
        ),
      )),
    );
  }
}

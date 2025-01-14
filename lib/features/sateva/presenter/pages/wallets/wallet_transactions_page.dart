import 'package:flutter/material.dart';
import 'package:kumbuz/core/utils/currency_utils.dart';
import 'package:kumbuz/features/sateva/data/models/bank_account.dart';
import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/assets.dart';
import '../../../../../configs/theme/colors.dart';
import '../../../../../shared/presentation/ui/spacing.dart';
import '../../../data/models/wallet_transaction.dart';
import '../../../domain/usecases/controllers/wallet_ controller.dart';
import '../../widget/day_transaction_widget.dart';
import '../transactions/transactions_page.dart';

class WalletTransactionsPage extends StatefulWidget {
  Wallet wallet;
  BankAccount? bankAccount;

  WalletTransactionsPage({super.key, required this.wallet, this.bankAccount});

  @override
  State<WalletTransactionsPage> createState() => _WalletTransactionsPageState();
}

class _WalletTransactionsPageState extends State<WalletTransactionsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.wallet.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SizedBox(
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                ),
                Positioned(child: HeadWalletInfo()),
                Positioned(
                    top: size.height * 0.2,
                    child: Container(
                      width: size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Últimas transacções",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      debugPrint("Ver tudo...");

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TransactionsPage()));
                                    },
                                    child: Text(
                                      "Ver tudo",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              color: PRIMARY_COLOR,
                                              fontSize: 14),
                                    ))
                              ],
                            ),
                            const Spacing.y(),
                            Consumer<WalletController>(
                              builder: (_, _controller, child) {
                                return FutureBuilder(
                                    future: _controller.getTransactionsByWallet(
                                        "${widget.wallet.id}" ?? ""),
                                    builder: (_, snap) {
                                      if (!snap.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var transactions =
                                          snap.data as List<WalletTransaction>;

                                      if (transactions.isNotEmpty) {
                                        return Column(
                                          children: List.generate(
                                              transactions.length > 6
                                                  ? 6
                                                  : transactions.length,
                                              (index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: DayTransactionWidget(
                                                  transaction:
                                                      transactions[index]),
                                            );
                                          }),
                                        );
                                      }

                                      return Container(
                                        height: size.height * 0.55,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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

                                      // return Container(
                                      //   height: size.height / 2.5,
                                      //   width: size.width,
                                      //   child: Center(
                                      //     child: SvgPicture.asset(
                                      //       AppAssets.NoTransactions,
                                      //       width: size.width * 0.5,
                                      //     ),
                                      //   ),
                                      // );
                                    });
                              },
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget HeadWalletInfo() {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.25,
      // decoration: AppStyles.containerDecoration(context),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              "Balanço",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.bankAccount != null
                ? Column(
                    children: [
                      Text(
                        "${widget.bankAccount?.accountNumber}",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                : SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.monetization_on_outlined,
                    size: 50, color: Colors.white),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  currencyFormatUtils(widget.wallet.amount),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

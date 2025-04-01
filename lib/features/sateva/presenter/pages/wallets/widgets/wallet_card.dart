import 'package:flutter/material.dart';
import 'package:kumbuz/core/configs/theme/styles.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/open_finance/domain/usecases/get_bank_account_by_name.dart';
import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:kumbuz/features/sateva/presenter/pages/wallets/wallet_transactions_page.dart';

class WalletCard extends StatelessWidget {
  Wallet wallet;
  WalletCard({required this.wallet});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        var account = await DI.get<GetBankAccountByName>().handle(wallet.name);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WalletTransactionsPage(
                  wallet: wallet,
                  bankAccount: account,
                )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6.5,
        decoration: AppStyles.containerDecoration(context),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.account_balance_outlined,
                                  size: 35,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width / 1.8,
                                    child: Text(
                                      wallet.name ?? "",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // Text(
                                  //   AppCurrencyFormat.format(
                                  //       shoppinglist.calculateTotal()),
                                  //   style: TextStyle(
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.w400,
                                  //       color: Colors.grey),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(wallet.type ?? ""),
                      )
                    ],
                  ),
                  const Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              left: size.width * 0.82,
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    // PopupMenuItem(
                    //     onTap: () {
                    //       // shoplistForm(context, shoppinglist);
                    //     },
                    //     child: const Row(
                    //       children: [
                    //         Icon(Icons.edit),
                    //         SizedBox(
                    //           width: 5,
                    //         ),
                    //         Text("Editar")
                    //       ],
                    //     )),
                    PopupMenuItem(
                      child: const Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Remover")
                        ],
                      ),
                      onTap: () {},
                    )
                  ];
                },
                icon: Row(
                  children: [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            )
          ],
        ),
      ),
    );
  }
}

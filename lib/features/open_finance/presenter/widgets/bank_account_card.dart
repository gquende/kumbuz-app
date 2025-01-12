import 'package:flutter/material.dart';
import 'package:kumbuz/configs/theme/styles.dart';

import '../../../sateva/data/models/bank_account.dart';

class BankAccountCard extends StatelessWidget {
  BankAccount bank;
  BankAccountCard({required this.bank});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        //
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
                                      bank.bankName ?? "",
                                      style: TextStyle(
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
                        child: Text(bank.type ?? ""),
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
                      // Stack(
                      //   children: [
                      //     Container(
                      //       width: (size.width - 40),
                      //       height: 14,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(50),
                      //           color: Color(0xff67727d).withOpacity(0.1)),
                      //     ),
                      //     Container(
                      //       width: (size.width - 40) *
                      //           shoppinglist.getPercentBuyedByItem() /
                      //           100,
                      //       height: 14,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(50),
                      //           color: PRIMARYCOLOR),
                      //     ),
                      //     Positioned(
                      //         left: (size.width - 50) / 2,
                      //         child: Text(
                      //             "${(shoppinglist.getPercentBuyedByItem()).round()} %"))
                      //   ],
                      // )
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

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/core/configs/theme/colors.dart';
import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:kumbuz/features/sateva/presenter/pages/category/categories.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../../../app.dart';
import '../../../../domain/usecases/controllers/wallet_ controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _email =
      TextEditingController(text: "geraldo@gmail.com");
  TextEditingController dateOfBirth = TextEditingController(text: "04-19-1992");
  TextEditingController password = TextEditingController(text: "123456");

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<WalletController>();
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Container(
                        width: (size.width - 40) * 0.4,
                        child: Container(
                          child: Stack(
                            children: [
                              RotatedBox(
                                quarterTurns: -2,
                                child: CircularPercentIndicator(
                                  circularStrokeCap: CircularStrokeCap.round,
                                  backgroundColor: grey.withOpacity(0.3),
                                  radius: 110.0,
                                  lineWidth: 6.0,
                                  percent: 0.2,
                                  progressColor: PRIMARY_COLOR,
                                  center: Icon(Icons.person),
                                ),
                              ),
                              Positioned(
                                top: 13,
                                left: 13,
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/user-icon.jpg"),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${App.user!.name.toUpperCase()} ${App.user!.surname.toUpperCase()}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Text(
                            //   "",
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.w500,
                            //       color: black.withOpacity(0.4)),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FutureBuilder(
                      future: AppConfiguration.database!.walletDao.getAll(),
                      builder: (ctx, snap) {
                        if (!snap.hasData) {
                          return Center(
                            child: Text(""),
                          );
                        }
                        var wallets = snap.data as List<Wallet>;

                        if (wallets.isEmpty) {
                          return SizedBox();
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Contas"),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children:
                                    List.generate(wallets.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: PRIMARY_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: PRIMARY_COLOR
                                                  .withOpacity(0.01),
                                              spreadRadius: 10,
                                              blurRadius: 3,
                                              // changes position of shadow
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 25,
                                            bottom: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${wallets[index].name}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: white),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${CurrencyFormatter.format(wallets[index].amount, GetIt.instance.get<CurrencyFormatterSettings>())}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: white),
                                                ),
                                              ],
                                            ),
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //       borderRadius:
                                            //           BorderRadius.circular(10),
                                            //       border: Border.all(color: white)),
                                            //   child: Padding(
                                            //     padding: const EdgeInsets.all(13.0),
                                            //     child: Text(
                                            //       "Actualizar",
                                            //       style: TextStyle(color: white),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          );
                        }
                      })
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              /*Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2),
                child: Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: AppColors.textSecundaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Posso pedir credito?",
                              style: TextStyle(
                                color: AppColors.textSecundaryColor,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.textSecundaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),

              */
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoriesPage()));
                  },
                  child: Container(
                    width: size.width,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 2)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.library_books_sharp,
                                color: AppColors.textSecundaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Categorias",
                                style: TextStyle(
                                  color: AppColors.textSecundaryColor,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColors.textSecundaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2),
                child: Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: AppColors.textSecundaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Dívidas",
                              style: TextStyle(
                                color: AppColors.textSecundaryColor,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.textSecundaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2),
                child: Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.savings,
                              color: AppColors.textSecundaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Poupanças",
                              style: TextStyle(
                                color: AppColors.textSecundaryColor,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.textSecundaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2),
                child: Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 2)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: AppColors.textSecundaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Exportar",
                              style: TextStyle(
                                color: AppColors.textSecundaryColor,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColors.textSecundaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kumbuz/features/open_finance/presenter/bank_transactions_loading.dart';

import '../../../app.dart';
import '../../../core/setup_app.dart';
import '../../../utils/navigation_service.dart';
import '../domain/entity/bank_entity.dart';
import 'controllers/bank_controller.dart';

class BankPermission extends StatefulWidget {
  Bank bank;
  BankPermission({super.key, required this.bank});

  @override
  _BankPermissionState createState() => _BankPermissionState();
}

class _BankPermissionState extends State<BankPermission> {
  List<String> accountsName = [];
  final BankController _bankController = locator<BankController>();
  bool _loading = false;
  final _navigatorService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xffe5e5e5),
        body: FutureBuilder(
          future: _bankController
              .connectAccount(dotenv.get('REDIRECT_APP_NEW_ACCOUNT')),
          builder: (_, snap) {
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (accountsName.isEmpty || accountsName == null) {
              accountsName.add(((snap.data as Map)['accounts'] as List).first);
            }

            return Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.height / 8,
                        height: size.height / 8,
                        //child: ,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.bank.logoUrl),
                                fit: BoxFit.fill)),
                      ),
                      const Text(
                        "Sandbox Bank System",
                        style:
                            TextStyle(fontSize: 30, fontFamily: 'Poppins-Bold'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.info,
                                size: 40,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    // height: 100,
                                    child: const Text(
                                      " Estou ciente de que, ao fazer login, dou à SIA Nordigen Solutions acesso às seguintes informações: ",
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,
                                      // maxLines: 2,
                                      //overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: const Text(
                                      "- Acesso aos dados bancarios (Contas, Saldos e Transacçoes)",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                      // maxLines: 2,
                                      //overflow: TextOverflow.clip,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Você está dando consentimento para acessar as seguintes informações:",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: accountsName
                                    .map((account) => Column(
                                          children: [
                                            Text(
                                              "Conta: ${account.toUpperCase()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text("- Dados de conta"),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text("- Transacções"),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text("- Balanços"),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: Theme.of(context).primaryColor),
                          height: 56,
                          //color: menuColor,
                          child: SizedBox.expand(
                            child: TextButton(
                              onPressed: () async {
                                print('Get Bank Acoount...');
                                setLoading();
                                await _bankController.saveBankAccount(
                                    App.user, widget.bank,
                                    accountId: accountsName.first);
                                setLoading();

                                //_navigatorService.popAtHome();

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BankTransactionsLoading()),
                                    (route) => true);

                                //
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         ChangeCategoryOfBankTransaction()));
                              },
                              child: !_loading
                                  ? Text(
                                      'Permitir',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    )
                                  : CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  void setLoading() {
    setState(() {
      if (_loading == true) {
        _loading = false;
      } else {
        _loading = true;
      }
    });
  }
}

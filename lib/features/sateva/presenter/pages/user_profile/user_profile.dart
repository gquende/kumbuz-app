import 'package:flutter/material.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/utils/loading_screen.dart';
import 'package:kumbuz/features/sateva/presenter/pages/auth/controller/auth_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/auth/login.dart';
import 'package:kumbuz/features/sateva/presenter/pages/category/categories.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/kixikila_page.dart';
import 'package:kumbuz/features/sateva/presenter/pages/savings/savings_page.dart';
import 'package:kumbuz/features/sateva/presenter/pages/wallets/wallets_page.dart';

import '../../../../../app.dart';
import '../debts/debts_page.dart';

class UserProfile2 extends StatefulWidget {
  const UserProfile2({super.key});

  @override
  State<UserProfile2> createState() => _UserProfile2State();
}

class _UserProfile2State extends State<UserProfile2> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: const Icon(Icons.person),
                      radius: 45,
                      backgroundColor: theme.colorScheme.secondaryContainer,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${App.user?.name} ${App.user?.surname}",
                      style:
                          theme.textTheme.titleMedium?.copyWith(fontSize: 20),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Text(
                      "${App.user?.email}",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Geral",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color:
                        theme.colorScheme.secondaryContainer.withOpacity(0.3),
                    border:
                        Border.all(color: theme.colorScheme.secondaryContainer),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(
                    18,
                  ),
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 10,
                      // ),
                      InkWell(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const BankAccountsPage()));

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const WalletsPage()));
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_balance_outlined,
                              size: 32,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Contas bancárias",
                                style: theme.textTheme.titleSmall
                                    ?.copyWith(fontSize: 16))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SavingsPage(
                                    canNavigation: true,
                                  )));
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.savings,
                              size: 32,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Objectivos",
                                style: theme.textTheme.titleSmall
                                    ?.copyWith(fontSize: 16))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const KixikilaPage()));
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.handshake,
                              size: 32,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Kixikilas",
                                style: theme.textTheme.titleSmall
                                    ?.copyWith(fontSize: 16))
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CategoriesPage()));
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.category,
                              size: 32,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Categorias",
                                style: theme.textTheme.titleSmall
                                    ?.copyWith(fontSize: 16))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => const DebtsPage()));
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.money,
                              size: 32,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Dívidas",
                                style: theme.textTheme.titleSmall
                                    ?.copyWith(fontSize: 16))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Definições",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color:
                        theme.colorScheme.secondaryContainer.withOpacity(0.3),
                    border:
                        Border.all(color: theme.colorScheme.secondaryContainer),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(
                    18,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Loading.set(context);

                          await Future.delayed(Duration(seconds: 3));
                          var result = DI.get<AuthController>().logout();

                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(builder: (context) => Login()));

                          Loading.dispose(context);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => true);
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              size: 32,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Sair",
                                style: theme.textTheme.titleSmall
                                    ?.copyWith(fontSize: 16))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

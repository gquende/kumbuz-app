import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/core/configs/theme/styles.dart';
import 'package:kumbuz/core/setup_app.dart';

import '../domain/entity/bank_entity.dart';
import 'controllers/bank_controller.dart';
import 'presenter.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({Key? key}) : super(key: key);

  @override
  _AddBankAccountState createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  BankController _bankController = locator<BankController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Conexão Bancária"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Escolha o banco que você deseja acompanhar as suas transacções",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
              width: size.width,
              height: size.height / 1.5,
              child: FutureBuilder(
                future: _bankController.getBanks("pt"),
                builder: (_, snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<Bank> banks = snap.data as List<Bank>;
                  return ListView.builder(
                      itemCount: banks.length,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 4, right: 4, bottom: 4, top: 6),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      BankConnection(banks[index])));
                            },
                            child: Container(
                              width: size.width,
                              height: size.height / 12,
                              decoration:
                                  AppStyles.containerDecoration(context),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(banks[index].logoUrl),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Text(
                                      utf8.decode(
                                          utf8.encode(banks[index].name)),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Poppins-SemiBold',
                                          overflow: TextOverflow.fade),
                                    ),
                                  )
                                ],
                              ),
                              // decoration: BoxDecoration(),
                              // clipBehavior: Clip.none,
                            ),
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

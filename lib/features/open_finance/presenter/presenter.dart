import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/core/configs/config.dart';

import '../domain/entity/bank_entity.dart';
import 'bank_permission.dart';

class BankConnection extends StatefulWidget {
  Bank bank;
  BankConnection(this.bank);

  //const NordigenLogin({Key? key}) : super(key: key);

  @override
  State<BankConnection> createState() => _BankConnectionState();
}

class _BankConnectionState extends State<BankConnection> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("${widget.bank.name}"),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
        ),
        body: Center(
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
                  Text(
                    "Sandbox Bank System",
                    style: TextStyle(fontSize: 30, fontFamily: 'Poppins-Bold'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300]),
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
                                width: MediaQuery.of(context).size.width * 0.7,
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
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
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
                    padding: const EdgeInsets.all(28.0),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                        controller: _usernameController,
                        // cursorColor: Color,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: const Icon(
                            CupertinoIcons.person,
                            size: 30,
                            // color: AppColors.primaryColor,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          fillColor: AppColors.bgColor,
                          // focusColor: Colors.red,
                          // hoverColor: Colors.red,
                          labelText: 'Nome do Utilizador',
                          labelStyle: TextStyle(color: Colors.blue),
                          // border: OutlineInputBorder()),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28),
                    child: TextFormField(
                      cursorColor: Colors.blue,
                      obscureText: true,
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                      controller: _passwordController,
                      decoration: InputDecoration(
                          focusColor: Colors.blue,
                          filled: true,
                          prefixIcon: const Icon(
                            CupertinoIcons.padlock,
                            // color: Color(0xFF087622)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          fillColor: AppColors.bgColor,
                          labelText: 'Palavra passe',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: AppColors.primaryColor),
                      height: 56,
                      //color: menuColor,
                      child: SizedBox.expand(
                        child: TextButton(
                          onPressed: () async {
                            debugPrint('Connecting...');

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BankPermission(
                                      bank: widget.bank,
                                    )));
                            //_bankController.connectAccount(dotenv.get('REDIRECT_APP_NEW_ACCOUNT'));
                          },
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
        ),
      ),
    );
  }
}

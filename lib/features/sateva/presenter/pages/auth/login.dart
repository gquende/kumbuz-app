import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/data/models/user.dart';
import 'package:kumbuz/features/sateva/presenter/pages/auth/controller/auth_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/auth/sign_up.dart';
import 'package:kumbuz/features/sateva/presenter/pages/newhome/presentation/newhome.dart';

import '../../../../../app.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var controller = DI.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      // backgroundColor: AppColors.primaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Image(
                        image: AssetImage(AppFiles.LOGO),
                        width: 150,
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 12, color: AppColors.primaryColor),
                      controller: _usernameController,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                          filled: true,
                          prefixIcon: const Icon(
                            CupertinoIcons.person,
                            size: 30,
                            color: Color(0xFF665ced),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFaea8ff)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF665ced)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          fillColor: AppColors.bgColor,
                          // focusColor: Colors.red,
                          // hoverColor: Colors.red,
                          labelText: 'Nome do Utilizador',
                          labelStyle: TextStyle(color: Color(0xFF665ced)),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28),
                    child: TextFormField(
                      cursorColor: AppColors.primaryColor,
                      obscureText: true,
                      style: TextStyle(
                          fontSize: 12, color: AppColors.primaryColor),
                      controller: _passwordController,
                      decoration: InputDecoration(
                          focusColor: AppColors.primaryColor,
                          filled: true,
                          prefixIcon: const Icon(CupertinoIcons.padlock,
                              color: Color(0xFF665ced)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFaea8ff)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF665ced)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11))),
                          fillColor: AppColors.bgColor,
                          labelText: 'Palavra passe',
                          labelStyle: TextStyle(color: Color(0xFF665ced)),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
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
                            print('inserido com sucesso...');

                            if (_usernameController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              var user = await controller.login2(
                                  _usernameController.text,
                                  _passwordController.text);
                              if (user != null) {
                                App.user = User(
                                    Random.secure().nextInt(1000),
                                    user.id,
                                    user.name,
                                    user.surname,
                                    user.username,
                                    user.password,
                                    "",
                                    user.createAt ?? "",
                                    user.updateAt ?? "");

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => NewHome()),
                                    (route) => false);
                              }
                            }
                          },
                          child: Obx(() {
                            return controller.isLoading.isTrue
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Entrar',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  );
                          }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: const Text("Nao tenho uma conta")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

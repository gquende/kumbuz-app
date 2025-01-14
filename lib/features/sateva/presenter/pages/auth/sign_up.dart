import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/features/sateva/data/models/user.dart';
import 'package:kumbuz/features/sateva/presenter/pages/auth/controller/auth_controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/newhome/presentation/newhome.dart';

import '../../../../../app.dart';
import '../../../../../core/utils/strings_utils.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  var isLoading = false.obs;

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        //resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //Todo Inserir o modo reverso quando se abre o teclado
          child: Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Image(
                            image: AssetImage(AppFiles.LOGO),
                            width: 150,
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Nome vazio";
                            }
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 12, color: AppColors.primaryColor),
                          controller: _nameController,
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(
                                CupertinoIcons.person,
                                size: 30,
                                color: AppColors.primaryColor,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFaea8ff)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF665ced)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              fillColor: AppColors.bgColor,
                              // focusColor: Colors.red,
                              // hoverColor: Colors.red,
                              labelText: 'Nome',
                              labelStyle: TextStyle(color: Color(0xFF665ced)),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Insira o sobrenome";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 12, color: AppColors.primaryColor),
                          controller: _surnameController,
                          cursorColor: AppColors.primaryColor,
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: Icon(
                                CupertinoIcons.person,
                                size: 30,
                                color: Color(0xFF665ced),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFaea8ff)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF665ced)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              fillColor: AppColors.bgColor,
                              // focusColor: Colors.red,
                              // hoverColor: Colors.red,
                              labelText: 'Sobrenome',
                              labelStyle:
                                  const TextStyle(color: Color(0xFF665ced)),
                              border: const OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 12, color: AppColors.primaryColor),
                          controller: _usernameController,
                          cursorColor: AppColors.primaryColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Insira um email válido";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              prefixIcon: const Icon(
                                CupertinoIcons.mail,
                                size: 30,
                                color: Color(0xFF665ced),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFaea8ff)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF665ced)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              fillColor: AppColors.bgColor,
                              // focusColor: Colors.red,
                              // hoverColor: Colors.red,
                              labelText: 'Email',
                              labelStyle:
                                  const TextStyle(color: Color(0xFF665ced)),
                              border: const OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: TextFormField(
                          cursorColor: AppColors.primaryColor,
                          obscureText: true,
                          style: TextStyle(
                              fontSize: 12, color: AppColors.primaryColor),
                          controller: _passwordController,
                          validator: (value) {
                            if (value! != _repeatPasswordController.text) {
                              return "A senha não coincide";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusColor: AppColors.primaryColor,
                              filled: true,
                              prefixIcon: const Icon(CupertinoIcons.padlock,
                                  color: Color(0xFF665ced)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFaea8ff)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF665ced)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              fillColor: AppColors.bgColor,
                              labelText: 'Palavra passe',
                              labelStyle:
                                  const TextStyle(color: Color(0xFF665ced)),
                              border: const OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: TextFormField(
                          cursorColor: AppColors.primaryColor,
                          obscureText: true,
                          style: TextStyle(
                              fontSize: 12, color: AppColors.primaryColor),
                          controller: _repeatPasswordController,
                          validator: (value) {
                            if (value! != _passwordController.text) {
                              return "A senha não coincide";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              focusColor: AppColors.primaryColor,
                              filled: true,
                              prefixIcon: const Icon(CupertinoIcons.padlock,
                                  color: Color(0xFF665ced)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFaea8ff)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF665ced)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11))),
                              fillColor: AppColors.bgColor,
                              labelText: 'Repita a Palavra passe',
                              labelStyle:
                                  const TextStyle(color: Color(0xFF665ced)),
                              border: const OutlineInputBorder()),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: AppColors.primaryColor),
                          height: 56,
                          //color: menuColor,
                          child: SizedBox.expand(child: Obx(() {
                            return TextButton(
                              onPressed: () async {
                                //Todo validar os dados do formulario;

                                if (_formKey.currentState!.validate()) {
                                  isLoading.value = true;
                                  User newUser = User(
                                      0,
                                      hashData(_usernameController.text),
                                      _nameController.text,
                                      _surnameController.text,
                                      _usernameController.text,
                                      _passwordController.text,
                                      "Sem Perfil",
                                      DateTime.now().toString(),
                                      DateTime.now().toString());
                                  App.user = newUser;

                                  await Future.delayed(Duration(seconds: 3));

                                  var value = await AuthController()
                                      .registerUser(newUser);

                                  if (value == true) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Container(
                                        child: const Text(
                                          "Utilizador cadastrado",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      backgroundColor: AppColors.primaryColor,
                                    ));
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NewHome()),
                                        (route) => false);
                                  }
                                  isLoading.value = false;
                                }
                              },
                              child: isLoading.isTrue
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Registar-se',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                            );
                          })),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text(
                    "Já tenho conta. Entrar",
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

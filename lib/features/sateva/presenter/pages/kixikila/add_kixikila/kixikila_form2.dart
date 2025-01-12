import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/configs/theme/colors.dart';
import 'package:kumbuz/features/sateva/domain/entities/user_entity.dart';
import 'package:kumbuz/features/sateva/presenter/pages/expense/controller/expense_controller.dart';
import 'package:kumbuz/main.dart';
import 'package:kumbuz/shared/presentation/ui/spacing.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../../../../app.dart';
import '../../../../../../core/di/dependecy_injection.dart';
import '../controller/kixikila_controller.dart';
import 'components/add_guest_dialog.dart';
import 'controllers/tag_controller.dart';

class KixikilaForm2 extends StatefulWidget {
  const KixikilaForm2({super.key});

  @override
  State<KixikilaForm2> createState() => _KixikilaForm2State();
}

class _KixikilaForm2State extends State<KixikilaForm2> {
  var controller = DI.get<KixikilaController>();
  List<String> guests = ["adolfo", "teste"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  dispose() {
    controller.loading.value = false;
    controller.resetForm();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Criar Kixikila",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.38,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                Positioned(
                    top: size.height * 0.07,
                    left: size.width * 0.1,
                    child: Container(
                      width: size.width * 0.8,
                      height: size.height * 0.65,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                spreadRadius: 2,
                                offset: Offset(0, 2))
                          ],
                          borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacing.y(),
                            Text("Descrição"),
                            Spacing.y(),
                            Container(
                              width: size.width,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Color(0xffe5e5e5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  controller: controller.descriptionController,
                                  decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.description_outlined),
                                      hintText: "",
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      focusColor: Color(0xff000000),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                      fillColor: Color(0xffe5e5e5),
                                      labelStyle:
                                          TextStyle(color: Color(0xff000000)),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ),
                            Spacing.y(),
                            Text("Valor"),
                            Spacing.y(),
                            Container(
                              width: size.width,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Color(0xffe5e5e5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.amountController,
                                  decoration: const InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.monetization_on_outlined),
                                      hintText: "",
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      focusColor: Color(0xff000000),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                      fillColor: Color(0xffe5e5e5),
                                      labelStyle:
                                          TextStyle(color: Color(0xff000000)),
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ),
                            const Spacing.y(),
                            const Text(
                              "Modo de pagamento",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacing.y(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: "inicio",
                                          groupValue: controller.paymentMethod,
                                          onChanged: (value) {
                                            setState(() {
                                              controller.paymentMethod = value!;
                                            });
                                          },
                                          fillColor: WidgetStatePropertyAll(
                                              PRIMARY_COLOR),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Início do mês"),
                                      ],
                                    )),
                                Container(
                                    width: 150,
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: "fim",
                                          groupValue: controller.paymentMethod,
                                          onChanged: (value) {
                                            setState(() {
                                              controller.paymentMethod = value!;
                                            });
                                          },
                                          fillColor: WidgetStatePropertyAll(
                                              PRIMARY_COLOR),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text("Fim do mês"),
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                // await _inviteUser();

                                await addGuestDialog(context);
                              },
                              child: Container(
                                  width: size.width,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person_add,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Convidados",
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  top: size.height * 0.8,
                  left: size.width * 0.10,
                  child: GestureDetector(onTap: () async {
                    if (await controller.createKixikila(App.user?.uuId ?? "",
                            controller.invitedUsers, context) ==
                        1) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Kixikila criada!"),
                        backgroundColor: Colors.greenAccent,
                      ));

                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Falha na criação da Kixikila!"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  }, child: Obx(() {
                    return Container(
                        width: size.width * 0.8,
                        height: size.height * 0.07,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: controller.loading.value == false
                            ? const Text(
                                "Criar",
                                style: TextStyle(color: Colors.white),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )));
                  })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _inviteUser() async {
    var size = MediaQuery.of(context).size;

    var isLoading = false.obs;

    MultipleSearchController multipleSearchController =
        MultipleSearchController();

    final _stringTagController = StringTagController();

    TextEditingController usernameTEController = TextEditingController();
    MyKixikilaGuestTagController tagController = MyKixikilaGuestTagController();
    var users = <UserEntity>[].obs;

    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Nome de utilizador"),
                            const SizedBox(
                              height: 5,
                            ),
                            const Spacing.y(),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                isLoading.value = true;

                                await controller.invitingUser(
                                    usernameTEController.text, context);

                                isLoading.value = false;
                              },
                              child: Container(
                                  width: size.width,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0, 0),
                                            color: Colors.black12,
                                            spreadRadius: .7,
                                            blurRadius: 2)
                                      ],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Obx(() {
                                    return Center(
                                      child: isLoading.value
                                          ? const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            )
                                          : const Text(
                                              "Convidar",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    );
                                  })),
                            ),
                          ],
                        ))),
              ),
            ),
          );
        },
        barrierDismissible: !isLoading.value);

    return;
  }

  // Future<void> _inviteUser() async {
  //   var size = MediaQuery.of(context).size;
  //
  //   var isLoading = false.obs;
  //
  //   TextEditingController usernameTEController = TextEditingController();
  //
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           child: GestureDetector(
  //             onTap: () {
  //               FocusScope.of(context).requestFocus(FocusNode());
  //             },
  //             child: SingleChildScrollView(
  //               child: Container(
  //                   width: MediaQuery.of(context).size.width,
  //                   decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(8)),
  //                   child: Padding(
  //                       padding: const EdgeInsets.all(16.0),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           const SizedBox(
  //                             height: 10,
  //                           ),
  //                           const Text("Nome de utilizador"),
  //                           const SizedBox(
  //                             height: 5,
  //                           ),
  //                           const Spacing.y(),
  //                           Container(
  //                             width: size.width,
  //                             height: 55,
  //                             decoration: BoxDecoration(
  //                                 color: Color(0xffe5e5e5),
  //                                 borderRadius: BorderRadius.circular(8)),
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(10),
  //                               child: TextField(
  //                                 keyboardType: TextInputType.text,
  //                                 controller: usernameTEController,
  //                                 decoration: const InputDecoration(
  //                                     prefixIcon: Icon(Icons.person),
  //                                     hintText: "",
  //                                     contentPadding:
  //                                         EdgeInsets.only(bottom: 10),
  //                                     focusColor: Color(0xff000000),
  //                                     filled: true,
  //                                     enabledBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide.none,
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(11))),
  //                                     focusedBorder: OutlineInputBorder(
  //                                         borderSide: BorderSide.none,
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(11))),
  //                                     fillColor: Color(0xffe5e5e5),
  //                                     labelStyle:
  //                                         TextStyle(color: Color(0xff000000)),
  //                                     border: OutlineInputBorder()),
  //                               ),
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             height: 20,
  //                           ),
  //                           GestureDetector(
  //                             onTap: () async {
  //                               isLoading.value = true;
  //
  //                               await controller.invitingUser(
  //                                   usernameTEController.text, context);
  //
  //                               isLoading.value = false;
  //                             },
  //                             child: Container(
  //                                 width: size.width,
  //                                 height: 55,
  //                                 decoration: BoxDecoration(
  //                                     color: Theme.of(context).primaryColor,
  //                                     boxShadow: const [
  //                                       BoxShadow(
  //                                           offset: Offset(0, 0),
  //                                           color: Colors.black12,
  //                                           spreadRadius: .7,
  //                                           blurRadius: 2)
  //                                     ],
  //                                     borderRadius: BorderRadius.circular(5)),
  //                                 child: Obx(() {
  //                                   return Center(
  //                                     child: isLoading.value
  //                                         ? const CircularProgressIndicator(
  //                                             valueColor:
  //                                                 AlwaysStoppedAnimation(
  //                                                     Colors.white),
  //                                           )
  //                                         : const Text(
  //                                             "Convidar",
  //                                             style: TextStyle(
  //                                                 color: Colors.white),
  //                                           ),
  //                                   );
  //                                 })),
  //                           ),
  //                         ],
  //                       ))),
  //             ),
  //           ),
  //         );
  //       },
  //       barrierDismissible: !isLoading.value);
  //
  //   return;
  // }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/configs/theme/styles.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';
import 'package:kumbuz/features/sateva/presenter/pages/kixikila/controller/kixikila_controller.dart';

import '../../../../../../../app.dart';
import '../../../../../../../shared/presentation/ui/spacing.dart';

class GuestKixikilaComponent extends StatefulWidget {
  KixikilaGuest guest;
  bool isNextReceiver;

  GuestKixikilaComponent({
    required this.guest,
    required this.isNextReceiver,
  });

  @override
  State<GuestKixikilaComponent> createState() => _GuestKixikilaComponentState();
}

class _GuestKixikilaComponentState extends State<GuestKixikilaComponent> {
  var controller = DI.get<KixikilaController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: 100,
          width: size.width,
          decoration: widget.isNextReceiver
              ? BoxDecoration(
                  // color: Theme.of(context).primaryColor.withOpacity(0.2),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2),
                  // boxShadow: const [
                  //   BoxShadow(
                  //       color: Colors.black12,
                  //       offset: Offset(0, 0.2),
                  //       spreadRadius: 0.1,
                  //       blurRadius: 10)
                  // ],
                  borderRadius: BorderRadius.circular(10))
              : AppStyles.containerDecoration(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.guest.user)
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_month,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(
                      width: 10,
                    ),
                    widget.isNextReceiver
                        ? Text("${widget.guest.updateAt ?? 'Sem registo'}")
                        : Text("${widget.guest.updateAt ?? '25-09-2024'}")
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    widget.isNextReceiver
                        ? Text("Próximo a receber")
                        : Text("${'Convidado'}")
                  ],
                ),
              ],
            ),
          ),
        ),
        widget.isNextReceiver
            ? Positioned(
                left: size.width * 0.82,
                top: 10,
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    width: 85,
                    height: 35,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.stars_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("Pagar",
                            style: TextStyle(
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ))
            : const SizedBox(),
        (shouldTheUserPay())
            ? !widget.isNextReceiver
                ? Positioned(
                    left: size.width * 0.72,
                    top: 10,
                    child: GestureDetector(
                      onTap: () async {},
                      child: Container(
                        width: 85,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_box,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Pago",
                                style: TextStyle(
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ))
                : SizedBox()
            : Positioned(
                left: size.width * 0.72,
                top: 10,
                child: GestureDetector(
                  onTap: () async {
                    await _payForm();
                  },
                  child: Container(
                    width: 85,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.money,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Pagar",
                            style: TextStyle(
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ))
      ],
    );
  }

  bool shouldTheUserPay() {
    // return App.user?.uuId == guest.userId && !isNextReceiver;

    if (widget.guest.lastPaymentDate.isNotEmpty) {
      if (DateTime.now().year ==
              DateTime.parse(widget.guest.lastPaymentDate).year &&
          DateTime.now().month ==
              DateTime.parse(widget.guest.lastPaymentDate).month &&
          !widget.isNextReceiver &&
          App.user?.uuId == widget.guest.userId) {
        return false;
      } else {
        return true;
      }
    } else if (widget.isNextReceiver) {
      return true;
    } else if (App.user?.uuId == widget.guest.userId) {
      return false;
    }

    return true;
  }

  Future<void> _payForm() async {
    var size = MediaQuery.of(context).size;

    TextEditingController payedValueTEController = TextEditingController();
    var isLoading = false.obs;

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
                            const Text("Valor a pagar"),
                            const SizedBox(
                              height: 5,
                            ),
                            const Spacing.y(),
                            Container(
                              width: size.width,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: const Color(0xffe5e5e5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: payedValueTEController,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.monetization_on),
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
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                isLoading.value = true;
                                if (await controller.payKixikila(
                                    widget.guest,
                                    double.parse(
                                        payedValueTEController.text))) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Pagamento feito!"),
                                    backgroundColor: Colors.greenAccent,
                                  ));

                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        "Não foi possível inserir o pagamento!"),
                                    backgroundColor: Colors.redAccent,
                                  ));
                                }

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
                                              "Pagar",
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
        barrierDismissible: !isLoading.value == true);

    return;
  }
}

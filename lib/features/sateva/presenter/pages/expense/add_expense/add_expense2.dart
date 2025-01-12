import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/presenter/pages/expense/controller/expense_controller.dart';
import 'package:kumbuz/shared/presentation/ui/spacing.dart';
import 'package:provider/provider.dart';

import '../../../../domain/usecases/controllers/wallet_ controller.dart';

class AddExpense2 extends StatefulWidget {
  const AddExpense2({super.key});

  @override
  State<AddExpense2> createState() => _AddExpense2State();
}

class _AddExpense2State extends State<AddExpense2> {
  final ExpenseController _controller = ExpenseController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    _controller.walletController = context.watch<WalletController>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Inserir Despesa",
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
                          boxShadow: [
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
                            Text("Conta"),
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
                                  decoration: InputDecoration(
                                      hintText: "",
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      focusColor: Color(0xff000000),
                                      filled: true,
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                      focusedBorder: const OutlineInputBorder(
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
                            Text("Categoria"),
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
                                  decoration: InputDecoration(
                                      hintText: "",
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      focusColor: Color(0xff000000),
                                      filled: true,
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                      focusedBorder: const OutlineInputBorder(
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
                                  controller: _controller.amountController,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.monetization_on_outlined),
                                      hintText: "",
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      focusColor: Color(0xff000000),
                                      filled: true,
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                      focusedBorder: const OutlineInputBorder(
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
                                  controller: _controller.descriptionController,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.description_outlined),
                                      hintText: "",
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10),
                                      focusColor: Color(0xff000000),
                                      filled: true,
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11))),
                                      focusedBorder: const OutlineInputBorder(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Data"),
                                    Spacing.y(),
                                    Container(
                                      width: size.width * 0.32,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          color: Color(0xffe5e5e5),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.date_range),
                                              hintText: "",
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 10),
                                              focusColor: Color(0xff000000),
                                              filled: true,
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide
                                                          .none,
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(11))),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  11))),
                                              fillColor: Color(0xffe5e5e5),
                                              labelStyle: TextStyle(
                                                  color: Color(0xff000000)),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Hora"),
                                    Spacing.y(),
                                    Container(
                                      width: size.width * 0.32,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          color: Color(0xffe5e5e5),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextField(
                                          decoration: InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.access_time_sharp),
                                              hintText: "",
                                              contentPadding:
                                                  EdgeInsets.only(bottom: 10),
                                              focusColor: Color(0xff000000),
                                              filled: true,
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide
                                                          .none,
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(11))),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  11))),
                                              fillColor: Color(0xffe5e5e5),
                                              labelStyle: TextStyle(
                                                  color: Color(0xff000000)),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  top: size.height * 0.8,
                  left: size.width * 0.10,
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.07,
                    child: Text(
                      "Confirmar",
                      style: TextStyle(color: Colors.white),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8)),
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

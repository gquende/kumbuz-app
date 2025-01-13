import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/data/models/debt.dart';
import 'package:kumbuz/features/sateva/presenter/pages/debts/controller/debt_controller_2.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../app.dart';

class AddDebt extends StatefulWidget {
  @override
  _AddDebtState createState() => _AddDebtState();
}

class _AddDebtState extends State<AddDebt> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _nameFieldController = TextEditingController();
  TextEditingController _amountFieldController = TextEditingController();
  TextEditingController _descriptionFieldController = TextEditingController();
  List<String> debtsType = ["Por receber", "Por pagar"];
  String typeSelected = "";
  bool payDebt = true;

  String _colorCode = "";

  late String _dateSelected;

  @override
  void initState() {
    _dateSelected = DateTimeManipulation.getFormatDateForSQLite(DateTime.now());
    typeSelected = debtsType.first;
    setDebtType(typeSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Nova Dívida",
          style: TextStyle(color: AppColors.textPrimaryColor),
        ),
      ),
      backgroundColor: Color(0xfff5f5f5),
      body: GestureDetector(
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Tipo",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.grey,
                                  ),
                                  isExpanded: true,
                                  value:
                                      debtsType.isEmpty ? null : typeSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      typeSelected = value!;
                                      setDebtType(value);
                                    });
                                  },
                                  items: debtsType
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  dropdownColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  borderRadius: BorderRadius.zero,
                                  alignment: Alignment.center,
                                  isDense: true,
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            payDebt ? "Pagar para:" : "Receber de:",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _nameFieldController,
                                  decoration: InputDecoration(
                                    fillColor: AppColors.greyColor,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                24),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Insira um nome";
                                    }
                                  },
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Valor",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _amountFieldController,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      fillColor: AppColors.greyColor,
                                      filled: true,
                                      hintStyle: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide.none)),
                                  onChanged: (value) {
                                    _formKey.currentState?.validate();
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Insira um valor";
                                    }
                                  },
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Data",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: GestureDetector(
                                  onTap: () {
                                    _seleccionarData(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${_dateSelected}"),
                                        const Icon(
                                          Icons.arrow_drop_down_circle,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ))),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Descrição",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _descriptionFieldController,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      fillColor: AppColors.greyColor,
                                      filled: true,
                                      hintStyle: TextStyle(
                                          fontFamily: 'Poppins-Medium',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide.none),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1),
                                          gapPadding: 10),
                                      errorMaxLines: 1),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Insira uma descrição";
                                    }
                                  },
                                  onChanged: (value) {
                                    _formKey.currentState?.validate();
                                  },
                                ),
                              )),
                        ],
                      )),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //Todo: Corrigir as percentagens do Orcamento!

                        Debt debt = Debt(
                            id: 0,
                            uuid: const Uuid().v4(),
                            userId: App.user!.uuId,
                            walletId: "",
                            type: typeSelected,
                            to: payDebt ? _nameFieldController.text : "",
                            from: !payDebt ? _nameFieldController.text : "",
                            amountTarget:
                                double.parse(_amountFieldController.text),
                            amount: 0,
                            date: _dateSelected,
                            time: TimeOfDay.now().toString(),
                            description: _descriptionFieldController.text,
                            color: "",
                            isDone: false,
                            createAt: _dateSelected,
                            updateAt: _dateSelected);

                        await context
                            .read<DebtController>()
                            .createDebt(debt, context);
                        //
                        // await context
                        //     .read<DebtsUsecases>()
                        //     .insertDebt(debt, context: context);

                        Navigator.of(context).pop();
                      }
                      // WalletController
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(),
                      child: Center(
                        child: Text("Salvar"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _seleccionarData(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        // firstDate: DateTime.now().subtract(Duration(days: 30)),
        lastDate: DateTime.now().add(Duration(days: 60)));

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // data = picked;
        _dateSelected = picked.toLocal().toString().substring(0, 10);
      });
    }
  }

  void setDebtType(String value) {
    switch (value) {
      case "Por receber":
        {
          setState(() {
            payDebt = false;
          });
        }
        break;
      case "Por pagar":
        {
          setState(() {
            payDebt = true;
          });
        }
        break;
      default:
        {}
    }
  }
}

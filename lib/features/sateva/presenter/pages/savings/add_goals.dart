import 'package:flutter/material.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/data/models/goals.dart';
import 'package:kumbuz/features/sateva/domain/usecases/goals_usecases.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../app.dart';

class AddGoals extends StatefulWidget {
  @override
  _AddGoalsState createState() => _AddGoalsState();
}

class _AddGoalsState extends State<AddGoals> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _nameFieldController = TextEditingController();
  TextEditingController _amountFieldController = TextEditingController();

  String _colorCode = "";

  late String _dateSelected;

  @override
  void initState() {
    _dateSelected = DateTimeManipulation.getFormatDateForSQLite(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Novo Objectivo",
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
            padding: const EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
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
                            "Nome",
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              24),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none),
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
                                    fillColor: AppColors.greyColor,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                24),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
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
                            "Data a cumprir",
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
                                        const Icon(Icons.arrow_drop_down_sharp)
                                      ],
                                    ),
                                  )))
                        ],
                      )),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //Todo: Corrigir as percentagens do Orcamento!
                        Goals goals = Goals(
                            id: 0,
                            uuId: Uuid().v4(),
                            userId: App.user!.uuId,
                            name: _nameFieldController.text,
                            amount: 0,
                            amountTarget:
                                double.parse(_amountFieldController.text),
                            targetDate: _dateSelected,
                            isDone: false,
                            percentDone: 0,
                            color: "",
                            createAt:
                                DateTimeManipulation.getFormatDateForSQLite(
                                    DateTime.now()),
                            updateAt:
                                DateTimeManipulation.getFormatDateForSQLite(
                                    DateTime.now()),
                            date: DateTimeManipulation.getFormatDateForSQLite(
                                DateTime.now()));
                        var id = context
                            .read<GoalsUsecases>()
                            .insertGoal(goals, context: context);
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
                      decoration: const BoxDecoration(),
                      child: const Center(
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
}

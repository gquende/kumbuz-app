import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/singletons/globals.dart';
import 'package:kumbuz/features/kcalculator/presenter/kcalculator.dart';
import 'package:kumbuz/features/sateva/data/models/income.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';
import 'package:kumbuz/features/sateva/domain/entities/transaction_entity.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/wallet_%20controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/income/controller/income_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../../app.dart';

class IncomeForm extends StatefulWidget {
  Income? income;
  TransactionEntity? transaction;

  IncomeForm({this.income, this.transaction});

  @override
  _IncomeFormState createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  late WalletController _walletController;
  late IncomeController controller;
  late String _date;
  late String _time;
  late Category _category;
  List<Category> categories = [];
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    controller = context.read<IncomeController>();

    _date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    _time = formatDate(DateTime.now(), [hh, ':', nn]);
    categories = IncomeCategoryList;

    _category = categories.first;
    setIncomeDataToUpdate();

    super.initState();
  }

  setIncomeDataToUpdate() {
    if (widget.income != null) {
      _amountController.text = "${widget.income?.amount}";
      _descriptionController.text = "${widget.income?.description}";
      _category = categories
          .where((value) => value.name == widget.income?.categoryId)
          .first;
      _date = "${widget.income?.date}";
      _time = "${widget.income?.time}";
    }
  }

  @override
  Widget build(BuildContext context) {
    _walletController = context.watch<WalletController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Registar receita"),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Data"),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              _seleccionarData(context);
                            },
                            child: Container(
                              width: 140,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                  child: Text(
                                _date,
                                style: const TextStyle(fontSize: 16),
                              )),
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Hora"),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              _seleccionarHora(context);
                            },
                            child: Container(
                              width: 140,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: AppColors.greyColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                  child: Text(
                                _time,
                                style: TextStyle(fontSize: 16),
                              )),
                            )),
                      ],
                    )
                  ],
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Valor"),
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
                              padding: const EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                controller: _amountController,
                                onTap: () async {
                                  _amountController
                                      .text = (await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Kcalculator(
                                                    value:
                                                        _amountController.text,
                                                  )))) ??
                                      _amountController.text;
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: -4)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Insira um valor";
                                  }
                                },
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Categoria"),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<Category>(
                                underline: SizedBox(),
                                icon: const Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.grey,
                                ),
                                isExpanded: true,
                                value: _category,
                                onChanged: (value) {
                                  setState(() {
                                    _category = value!;
                                  });
                                },
                                items: categories
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name),
                                        ))
                                    .toList(),
                                dropdownColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Descrição"),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Insira uma descrição";
                                  }
                                },
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                maxLines: 8,
                                keyboardType: TextInputType.text,
                                controller: _descriptionController,
                              ),
                            )),
                      ],
                    )),
                SizedBox(
                  height: 80,
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.income == null) {
                        Income income = Income(
                            0,
                            App.user!.uuId,
                            _date,
                            _time,
                            double.parse(_amountController.text),
                            _descriptionController.text,
                            //Todo Change to ID
                            _category.name,
                            App.wallet!.id as int,
                            DateTime.now().toString(),
                            DateTime.now().toString());

                        _walletController.addIncome(
                            walletId: App.wallet!.id as int, income: income);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Registo feito"),
                          backgroundColor: Colors.greenAccent,
                        ));
                        Navigator.of(context).pop();
                      } else {
                        widget.income!.description =
                            _descriptionController.text;
                        widget.income!.amount =
                            double.parse(_amountController.text);

                        widget.income!.time = _time;
                        widget.income!.date = _date;
                        widget.income!.category = _category.name;
                        widget.income!.updateAt = DateTime.now().toString();

                        widget.transaction!.time = _time;
                        widget.transaction!.date = _date;
                        widget.transaction!.description =
                            _descriptionController.text;
                        widget.transaction!.amount =
                            double.parse(_amountController.text);
                        widget.transaction!.updateAt =
                            DateTime.now().toString();

                        await controller.updateIncome(
                            income: widget.income as Income,
                            transaction:
                                widget.transaction as TransactionEntity,
                            context: context);

                        Navigator.of(context).pop();
                      }
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
    );
  }

  Future<Null> _seleccionarData(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 30)),
        lastDate: DateTime.now().add(Duration(days: 60)));

    if (picked != null && picked != DateTime.now()) {
//      print(
//          "A data seleccionada foi: ${data.toLocal().toString().substring(0, 10)}");
      setState(() {
        // data = picked;
        _date = picked.toLocal().toString().substring(0, 10);
        print(_date);
      });
    }
  }

  //
  Future<Null> _seleccionarHora(BuildContext context) async {
    var horaSeleccionada =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (horaSeleccionada != null && horaSeleccionada != TimeOfDay.now()) {
      setState(() {
        _time = horaSeleccionada.format(context);
        print(_time);
      });
    }
  }
}

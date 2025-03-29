import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/domain/entities/transaction_entity.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/expense_controlller.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/wallet_%20controller.dart';
import 'package:provider/provider.dart';

import '../../../../../app.dart';
import '../../../../../core/singletons/globals.dart';
import '../../../../kcalculator/presenter/kcalculator.dart';
import '../../../domain/entities/category.dart';

class AddExpense extends StatefulWidget {
  Expense? expense;
  TransactionEntity? transaction;

  AddExpense({super.key, this.expense, this.transaction});

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  late WalletController _walletController;
  late String _date;
  late String _time;
  late Category _category;

  late ExpenseController expenseController;

  TextEditingController _amountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    _time = formatDate(DateTime.now(), [hh, ':', nn]);
    expenseController = context.read<ExpenseController>();
    _category = GlobalExpenseCategoryList.first;
    setExpenseDataToUpdate();
    super.initState();
  }

  setExpenseDataToUpdate() {
    if (widget.expense != null) {
      _amountController.text = "${widget.expense?.amount}";
      _descriptionController.text = "${widget.expense?.description}";
      _category = GlobalExpenseCategoryList.where(
          (value) => value.name == widget.expense?.category).first;
      _date = "${widget.expense?.date}";
      _time = "${widget.expense?.time}";
    }
  }

  @override
  Widget build(BuildContext context) {
    _walletController = context.watch<WalletController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Despesa"),
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
                        Text("Data"),
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
                                style: TextStyle(fontSize: 16),
                              )),
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Hora"),
                        SizedBox(
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
                              padding: const EdgeInsets.all(4.0),
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Insira um valor";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
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
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.grey,
                                  ),
                                  value: GlobalExpenseCategoryList.isEmpty
                                      ? null
                                      : _category,
                                  onChanged: (value) {
                                    setState(() {
                                      _category = value!;
                                    });
                                  },
                                  items: GlobalExpenseCategoryList.map(
                                      (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.name),
                                          )).toList(),
                                  dropdownColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                ))),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Descrição"),
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
                                maxLines: 8,
                                keyboardType: TextInputType.text,
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 80,
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Expense expense = Expense(
                          0,
                          App.user!.uuId,
                          _date,
                          _time,
                          double.parse(_amountController.text),
                          _descriptionController.text,
                          _category.name,
                          App.wallet!.id as int,
                          DateTime.now().toString(),
                          DateTime.now().toString());

                      if (widget.expense == null) {
                        _walletController.addExpense(
                            walletId: App.wallet!.id,
                            expense: expense,
                            context: context);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Registo feito"),
                          backgroundColor: Colors.greenAccent,
                        ));
                        Navigator.of(context).pop();
                      } else {
                        widget.expense!.description =
                            _descriptionController.text;
                        widget.expense!.amount =
                            double.parse(_amountController.text);
                        widget.expense!.time = _time;
                        widget.expense!.date = _date;
                        widget.expense!.category = _category.name;
                        widget.expense!.updateAt = DateTime.now().toString();

                        await expenseController.updateExpense(
                            widget.expense as Expense,
                            widget.transaction as TransactionEntity,
                            context: context);
                        Navigator.of(context).pop();
                      }
                    }

                    // WalletController
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(),
                    child: Center(
                      child: widget.expense == null
                          ? Text("Salvar")
                          : Text("Actualizar"),
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
        firstDate: DateTime(2000),
        // firstDate: DateTime.now().subtract(Duration(days: 30)),
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

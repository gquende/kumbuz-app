import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/core/singletons/globals.dart';
import 'package:kumbuz/utils/datetime_manipulation.dart';
import 'package:kumbuz/features/sateva/data/models/budget.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/budget_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../app.dart';
import '../../../kcalculator/presenter/kcalculator.dart';
import '../../domain/entities/category.dart';

class AddBudget extends StatefulWidget {
  @override
  _AddBudgetState createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _nameFieldController = TextEditingController();
  TextEditingController _amountFieldController = TextEditingController();

  late Category categorySelected;

  // Category categorySelected= Category(, name, color, iconUrl);
  String _colorCode = "";
  late List<Category> categories;
  late String _period;

  @override
  void initState() {
    // TODO: Buscar as categorias da Base de dados
    categories = GlobalExpenseCategoryList;
    categorySelected = categories.first;

    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Novo Orçamento",
          style: TextStyle(color: AppColors.textPrimaryColor),
        ),
      ),
      backgroundColor: Color(0xfff5f5f5),
      body: GestureDetector(
        onTap: () async {
          // print(
          //     "This is Expense: ${await App.database!.expenseDao.getTotalAmountOfMonthWithCategory("0, "Alimentação")}");

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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Nome",
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
                                  keyboardType: TextInputType.text,
                                  controller: _nameFieldController,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.greyColor,
                                      enabledBorder: InputBorder.none,
                                      filled: true,
                                      hintStyle: TextStyle(
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
                                  readOnly: true,
                                  onTap: () async {
                                    Get.bottomSheet(
                                      Kcalculator(
                                        value: _amountFieldController.text,
                                      ),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ).then((value) {
                                      print("VALOR:: $value");

                                      setState(() {
                                        _amountFieldController.text = value ??
                                            _amountFieldController.text;
                                      });
                                    });

                                    /* _amountFieldController.text =
                                        (await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Kcalculator(
                                                          value:
                                                              _amountFieldController
                                                                  .text,
                                                        )))) ??
                                            _amountFieldController.text;*/
                                  },
                                  decoration: InputDecoration(
                                      fillColor: AppColors.greyColor,
                                      enabledBorder: InputBorder.none,
                                      filled: true,
                                      hintStyle: TextStyle(
                                          fontFamily: 'Raleway',
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
                            "Categoria",
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
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton<Category>(
                                  onTap: () {
                                    debugPrint("Taped on Category...");
                                  },
                                  underline: null,
                                  isExpanded: true,
                                  value: categorySelected,
                                  dropdownColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  onChanged: (value) async {
                                    var budget = await context
                                        .read<BudgetController>()
                                        .getBudgetByCategory(value!.name);
                                    if (budget != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "Já existe um Orçamento com a categoria: ${value.name}")));
                                    } else {
                                      setState(() {
                                        categorySelected = value;
                                      });
                                    }
                                  },
                                  items: categories
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.name),
                                          ))
                                      .toList(),
                                ),
                              )),
                        ],
                      )),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //Todo: Corrigir as percentagens do Orcamento!

                        Budget budget = Budget(
                            0,
                            Uuid().v4(),
                            categorySelected.uuid,
                            App.user!.uuId,
                            _nameFieldController.text,
                            categorySelected.name,
                            double.parse(_amountFieldController.text),
                            0,
                            DateTimeManipulation.getDateOfTheFirstDayOfMonth(
                                DateTime.now()),
                            DateTimeManipulation.getDateOfTheLastDayOfMonth(
                                DateTime.now()),
                            0,
                            DateTime.now().toString(),
                            DateTime.now().toString());

                        var id = context
                            .read<BudgetController>()
                            .createBudget(budget);

                        if (id != null) {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                    title: const Text('Orçamento adicionada'),
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: Lottie.asset(
                                              AppFiles.done_animation),
                                        ),
                                      )
                                    ]);
                              });

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
      ),
    );
  }
}

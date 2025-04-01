import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kumbuz/core/configs/config.dart';
import 'package:kumbuz/features/sateva/presenter/pages/base/pages/root_app.dart';
import 'package:provider/provider.dart';

import '../../../../core/singletons/globals.dart';
import '../../data/models/budget.dart';
import '../../domain/entities/category.dart';
import '../../domain/usecases/controllers/budget_controller.dart';
import 'add_budget.dart';

class NewBudget extends StatelessWidget {
  const NewBudget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                        child: Text(
                      "Criar um orçamento é forma mais fácil de controlar  seus gastos",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecundaryColor),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SvgPicture.asset("assets/images/budget.svg"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Tenha um orçamento baseado no teus gastos históricos, ou crie um manualmente",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textSecundaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                            print('Abrir a recomendação...');

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ProcessingBudget()));
                          },
                          child: Text(
                            'Ser Recomendado',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: AppColors.textSecundaryColor),
                      height: 56,
                      //color: menuColor,
                      child: SizedBox.expand(
                        child: TextButton(
                          onPressed: () async {
                            print('Inserção Manual...');
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => AddBudget()));
                            // await db.incomeDao.insertItem(
                            //     Income(1, '', '', '', 200, '', '', '', '', ''));
                          },
                          child: Text(
                            'Inserir manual',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProcessingBudget extends StatefulWidget {
  @override
  _ProcessingBudgetState createState() => _ProcessingBudgetState();
}

class _ProcessingBudgetState extends State<ProcessingBudget> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _nameFieldController = TextEditingController();

  //TextEditingController _amountFieldController = TextEditingController();

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
              padding: const EdgeInsets.all(8.0),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoadingPredictBudget(
                                _nameFieldController.text,
                                categorySelected.name,
                                "mes")));
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
                        child: Text("Continuar"),
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

class LoadingPredictBudget extends StatefulWidget {
  String name, category, period;

  LoadingPredictBudget(this.name, this.category, this.period);

  @override
  State<LoadingPredictBudget> createState() => _LoadingPredictBudgetState();
}

class _LoadingPredictBudgetState extends State<LoadingPredictBudget> {
  bool load = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: context.read<BudgetController>().predictBudgetByCategory(
              widget.name, widget.period, widget.category),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              loading();
              return Center(
                child: load
                    ? CircularProgressIndicator()
                    : Text("Excedeu o tempo do Servidor"),
              );
            }
            Budget budget = snapshot.data as Budget;

            if (budget != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: size.width,
                      height: size.height / 4,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 1),
                            spreadRadius: 1),
                      ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Como base os seus gastos em: ${widget.category} previmos um orçamento de: ",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${budget.amount} KZS",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => RootApp()),
                                (route) => false);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: AppColors.primaryColor,
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black12,
                              side: BorderSide(color: Colors.black12)),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 40,
                            decoration: BoxDecoration(),
                            child: Center(
                              child: Text("Cancelar"),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await context
                                .read<BudgetController>()
                                .createBudget(budget, context);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => RootApp()),
                                (route) => false);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.primaryColor),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 40,
                            decoration: BoxDecoration(),
                            child: Center(
                              child: Text("Confirmar"),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return Center(
              child: Text("Erro, ao tentar predizer um orçamento"),
            );
          },
        ),
      ),
    );
  }

  Future<void> loading() async {
    Future.delayed(Duration(seconds: 20)).whenComplete(() {
      setState(() {
        load = false;
      });
    });
  }
}

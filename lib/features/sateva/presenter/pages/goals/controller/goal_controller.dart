import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../app.dart';
import '../../../../../../core/utils/datetime_manipulation.dart';
import '../../../../data/models/goals.dart';
import '../../../../domain/entities/category.dart';
import '../../../../domain/usecases/controllers/wallet_ controller.dart';
import '../../../../domain/usecases/goals_usecases.dart';

class GoalController extends GetxController {
  late WalletController walletController;
  late String date;
  late String time;
  late Category _category;

  List<Category> categories = [];

  TextEditingController amountController = TextEditingController();
  TextEditingController nameFieldController = TextEditingController();
  var dateController = TextEditingController().obs;
  GlobalKey<FormState> formKey = GlobalKey();

  var isLoading = false.obs;
  var dateSelected =
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()).obs;

  Future<void> createGoal(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 2));
      Goals goal = Goals(
          id: 0,
          uuId: Uuid().v4(),
          userId: App.user!.uuId,
          name: nameFieldController.text,
          amount: 0,
          amountTarget: double.parse(amountController.text),
          targetDate: dateSelected.value,
          isDone: false,
          percentDone: 0,
          color: "",
          createAt: DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
          updateAt: DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
          date: DateTimeManipulation.getFormatDateForSQLite(DateTime.now()));
      var id = await context
          .read<GoalsUsecases>()
          .insertGoal(goal, context: context);

      if (id! > 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Objetivo criado!"),
          backgroundColor: Colors.greenAccent,
        ));

        _resetData();
      }
      isLoading.value = false;
      // Navigator.of(context).pop();
    }
  }

  Future<Null> seleccionarData(BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        // firstDate: DateTime.now().subtract(Duration(days: 30)),
        lastDate: DateTime.now().add(const Duration(days: 60)));

    if (picked != null && picked != DateTime.now()) {
      dateSelected.value = picked.toLocal().toString().substring(0, 10);

      dateController.value.text = dateSelected.value;
    }
  }

  void _resetData() {
    amountController.text = "";
    nameFieldController.text = "";
  }
}

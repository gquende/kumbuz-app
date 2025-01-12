import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/singletons/globals.dart';
import '../../../../domain/entities/category.dart';
import '../../../../domain/usecases/controllers/wallet_ controller.dart';

class ExpenseController extends GetxController {
  //TextEditingController nameFieldController = TextEditingController();
  //TextEditingController valueFieldController = TextEditingController();
  //TextEditingController describeFieldController = TextEditingController();

  late WalletController walletController;
  late String date;
  late String time;
  late Category category;
  List<Category> categories = [];
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  ExpenseController() {
    this.date = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    time = formatDate(DateTime.now(), [hh, ':', nn]);
    category = GlobalExpenseCategoryList.first;
  }
}

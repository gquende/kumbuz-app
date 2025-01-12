import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:kumbuz/features/sateva/presenter/pages/newhome/presentation/newhome.dart';

import '../../../core/setup_app.dart';
import 'controllers/bank_controller.dart';

class BankTransactionsLoading extends StatefulWidget {
  const BankTransactionsLoading({super.key});

  @override
  State<BankTransactionsLoading> createState() =>
      _BankTransactionsLoadingState();
}

class _BankTransactionsLoadingState extends State<BankTransactionsLoading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 5)).then((value) async {
      await locator<BankController>().save();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Conta adicionada!"),
        backgroundColor: Colors.green,
      ));

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const NewHome()),
          (route) => true);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        child: Center(
          child: LoadingAnimationWidget.threeRotatingDots(
              color: Theme.of(context).primaryColor, size: 50),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  double expense;
  double income;
  // double balance;
  DateTime? date;
  BalanceCard({required this.income, required this.expense, this.date});
  // const BalanceCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width,
            height: size.height / 3.5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Visão geral",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Receita"),
                      Text("$income"
                          "")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Despesa"),
                      Text(
                        "-$income",
                        style: TextStyle(color: Colors.redAccent),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Balanço"),
                      Text("${income - expense}"
                          ""),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Container(child: PieTR()),
      ],
    );
  }
}

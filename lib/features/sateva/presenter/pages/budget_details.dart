import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/data/models/budget.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/presenter/widget/day_transactions.dart';

class BudgetDetails extends StatefulWidget {
  Budget budget;

  // const BudgetDetails({Key? key}) : super(key: key);
  BudgetDetails({required this.budget});

  @override
  State<BudgetDetails> createState() => _BudgetDetailsState();
}

class _BudgetDetailsState extends State<BudgetDetails> {
  // List<WalletTransaction>
  late List<Expense> _expenses;
  late List<WalletTransaction> budgetTransactions;

  @override
  void initState() {
    budgetTransactions = transactionsMock;
    // TODO: implement initState
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("${widget.budget.name}")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(Icons.eighteen_mp),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size.width / 1.8,
                                          child: Text(
                                            "${widget.budget.name}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Poppins-Bold',
                                                color: Colors.black54),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          "${widget.budget.amount.abs()} Kzs",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Poppins-Medium',
                                              color: Colors.grey),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => BudgetDetails(
                                                budget: widget.budget)));
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Color(0xffe5e5e5),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                        Divider(
                          height: 9,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.budget.percentComplete!.round()}% Gasto",
                                      style: TextStyle(
                                          fontFamily: 'Poppins-SemiBold',
                                          fontSize: 16,
                                          color: Colors.grey),
                                      // style: Text(),
                                    ),
                                    Text(
                                      "${widget.budget.amountConsume} Kzs",
                                      style: TextStyle(
                                          fontFamily: 'Poppins-SemiBold',
                                          fontSize: 18,
                                          color: Colors.pinkAccent),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.budget.amount -
                                                  (widget.budget.amountConsume
                                                      as double) >=
                                              0
                                          ? "Restante"
                                          : "Ultrapassou!",
                                      style: TextStyle(
                                          fontFamily: 'Poppins-SemiBold',
                                          fontSize: 16,
                                          color: Colors.grey),
                                      // style: Text(),
                                    ),
                                    Text(
                                      "${widget.budget.amount - (widget.budget.amountConsume as double)} Kzs",
                                      style: TextStyle(
                                          fontFamily: 'Poppins-SemiBold',
                                          fontSize: 18,
                                          color: Colors.blue),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: (size.width - 40),
                                  height: 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color:
                                          Color(0xff67727d).withOpacity(0.1)),
                                ),
                                Container(
                                  width: (size.width - 40) *
                                      ((widget.budget.percentComplete
                                              as double) /
                                          100),
                                  height: 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.pinkAccent),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width,
                  height: size.height / 2,
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Center(
                    child: Text(
                      "Grafico",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(budgetTransactions.length, (index) {
                    return DayTransactiosListWidget(
                        date: DateTime.now(), transactions: budgetTransactions);
                  }),
                )
              ],
            ),
          ),
        ),
      ),
      // body: ,
    );
  }
}

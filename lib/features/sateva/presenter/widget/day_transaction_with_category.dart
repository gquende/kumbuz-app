import 'package:flutter/material.dart';
import 'package:kumbuz/core/mock_data.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';

import '../../../../configs/config.dart';
import '../../data/models/wallet_transaction.dart';

class DayTransactionWithCategory extends StatefulWidget {
  // const DayTransactionWidget({Key? key}) : super(key: key);

  WalletTransaction transaction;
  List<Category> categories;
  DayTransactionWithCategory(
      {required this.transaction, required this.categories});

  @override
  State<DayTransactionWithCategory> createState() =>
      _DayTransactionWithCategoryState();
}

class _DayTransactionWithCategoryState
    extends State<DayTransactionWithCategory> {
  late Category _category;

  @override
  void initState() {
    // TODO: implement initState
    _category = widget.categories.last;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    child: setIcon(widget.transaction.type),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: setColor(widget.transaction.type)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Text(
                          widget.transaction.description,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.transaction.amount} KZS",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.transaction.date,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      Text(
                        setText(widget.transaction.type),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  DropdownButton(
                    items: widget.categories.map((e) {
                      return DropdownMenuItem(
                          value: e, child: Text("${e.name}"));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _category = value as Category;
                      });

                      if (widget.transaction.type == "expense") {
                        for (int i = 0; i < expenses.length; i++) {
                          if (expenses[i].uuId == widget.transaction.itemId) {
                            expenses[i].category = _category.name;
                            break;
                          }
                        }
                      } else {
                        for (int i = 0; i < incomes.length; i++) {
                          if (incomes[i].uuId == widget.transaction.itemId) {
                            incomes[i].categoryId = _category.name;
                            break;
                          }
                        }
                      }
                    },
                    value: _category,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  setIcon(String type) {
    switch (type) {
      case 'income':
        {
          return Icon(
            Icons.call_made,
            color: Colors.white,
          );
        }
      case 'goal':
        {
          return Icon(
            Icons.savings,
            color: Colors.white,
          );
        }
      case 'expense':
        {
          return Icon(
            Icons.call_received,
            color: Colors.white,
          );
        }
      default:
        {
          return Icon(
            Icons.error,
            color: Colors.white,
          );
        }
    }
  }

  String setText(String type) {
    switch (type) {
      case 'income':
        {
          return "Receita";
        }

      case 'goal':
        {
          return "Poupança";
        }
      case 'expense':
        {
          return "Despesa";
        }
      default:
        {
          return "Sem categoria";
        }
    }
  }

  setColor(String type) {
    switch (type) {
      case 'income':
        {
          return AppColors.primaryColor;
        }

      case 'goal':
        {
          return Colors.purple;
        }
      case 'expense':
        {
          return Colors.pinkAccent;
        }
      default:
        {
          return Colors.grey;
        }
    }
  }
}

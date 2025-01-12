import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/configs/theme/colors.dart';
import 'package:kumbuz/core/setup_app.dart';
import 'package:kumbuz/core/singletons/globals.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/expense_controlller.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/wallet_%20controller.dart';
import 'package:kumbuz/features/sateva/presenter/pages/transactions/controller/transaction_controller.dart';
import 'package:kumbuz/features/sateva/presenter/widget/categoryCard.dart';
import 'package:kumbuz/features/sateva/presenter/widget/chart.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart'; // import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../core/utils/datetime_manipulation.dart';
import '../../income/controller/income_controller.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String selectedDate = '';
  List<Category> _categoriesData = [];
  int _monthSelected = 0;

//  ?\final _positionedListController = ItemScrollController();
  final scrolController = ScrollController();
  bool loading = true;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoriesData = ExpensePerCategoryGlobalList;
    _monthSelected = DateTime.now().month - 1;
    selectedDate =
        DateTimeManipulation.getYearAndMonthForSQliteFormat(DateTime.now());

    print("This the date: ${selectedDate}");
    /* _positionedListController.scrollTo(
        index: _monthSelected, duration: Duration(seconds: 1));
    */
  }

  @override
  Widget build(BuildContext context) {
    context.watch<WalletController>();
    context.watch<IncomeController>();
    context.watch<TransactionController>();
    context.watch<ExpenseController>();

    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          monthList(),
          SizedBox(
            height: 20,
          ),

          // BalanceCard(
          //   income: 100,
          //   expense: 10,
          // ),

          FutureBuilder(
            future: locator<ExpenseController>()
                .getSumByCategoryOfMonth(selectedDate),
            builder: (ctx, snap) {
              if (!snap.hasData) {
                setLoading();
                return Container(
                  height: size.height * 0.7,
                  child: Center(
                    child: !loading
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.only(top: 200),
                            child: Text("Sem dados para mostrar"),
                          ),
                  ),
                );
              }
              //await loadExpenseChartData(date);

              if ((snap.data as List).isEmpty) {
                return Container(
                  height: size.height * 0.6,
                  child: Center(
                    child: Text("Sem dados para mostrar"),
                  ),
                );
              }

              loadExpenseChartData(selectedDate);

              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Consumer<WalletController>(
                              builder: (ctx, controller, index) {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 4,
                                //color: Colors.redAccent,
                                child: PieChartWidget(listChartData));
                          }),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: listChartData.map((e) {
                              return Row(
                                children: [
                                  SizedBox(
                                    height: 5,
                                    width: 5,
                                    child: CircleAvatar(
                                      backgroundColor: e.color,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Text(
                                      e.name,
                                      overflow: TextOverflow.clip,
                                    ),
                                  )
                                ],
                              );
                            }).toList(),
                          )
                        ],
                        // child:
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: locator<ExpenseController>()
                          .getSumByCategoryOfMonth(selectedDate),
                      builder: (ctx, snap) {
                        if (!snap.hasData) {
                          return Text("");
                        }

                        _categoriesData = snap.data as List<Category>;
                        return Container(
                          height: size.height / 3.5,
                          child: SizedBox(
                              width: size.width,
                              height: size.height / 4.5,
                              child: ListView.builder(
                                itemCount: _categoriesData.length,
                                itemBuilder: (ctx, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        debugPrint(
                                            "Taped on: ${_categoriesData[index].name}");
                                      },
                                      child: CategoryCard(
                                          _categoriesData[index], index),
                                    ),
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                              )),
                        );
                      }),
                ],
              );
              //return
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget monthList() {
    var month = [
      "Janeiro",
      "Fevereiro",
      "Março",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro",
    ];

    Future.delayed(Duration(milliseconds: 200)).then((value) {
      itemScrollController.scrollTo(
          index: _monthSelected <= 1 ? _monthSelected : _monthSelected - 2,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic);
      //
      // itemScrollController.jumpTo(index: _monthSelected - 1);
    });

    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: month.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () async {
                  if ((index + 1) < 10)
                    selectedDate = "${DateTime.now().year}-0${index + 1}";
                  else
                    selectedDate = "${DateTime.now().year}-${index + 1}";
                  await loadExpenseChartData(selectedDate,
                      month: "${index + 1}");
                  //Todo Adicionar a parte que coloca os dados de expense na Lista horizontal

                  setState(() {
                    _monthSelected = index;
                    print(
                        "This is the month: $_monthSelected  and Date : $selectedDate");
                  });
                },
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: index == _monthSelected
                          ? AppColors.primaryColor
                          : Colors.white),
                  child: Center(
                    child: Text(
                      "${month[index]}",
                      style: TextStyle(
                          fontSize: 12,
                          color: index == _monthSelected
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _calendar() {
    return Container(
      // height: 100,
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2050, 3, 14),
        focusedDay: _focusedDay,
        // locale: 'pt_PT',
        calendarFormat: CalendarFormat.week,
        selectedDayPredicate: (day) {
          return isSameDay(_focusedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          debugPrint(selectedDay.toString());
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      ),
      color: Colors.white,
    );
  }

  setLoading() async {
    Future.delayed(Duration(seconds: 10)).whenComplete(() {
      if (loading == true) {
        setState(() {
          loading = false;
        });
      }
    });
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/core/utils/utils.dart';
import 'package:kumbuz/features/sateva/domain/usecases/controllers/expense_controlller.dart';

import '../../../../core/setup_app.dart';

class PieChartWidget extends StatefulWidget {
  List<ChartData> data;

  PieChartWidget(this.data);

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int? touchedIndex;

  List<PieChartSectionData> getSections(int? touchedIndex) => widget.data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final isTouched = index == touchedIndex;
        final double fontSize = isTouched ? 12 : 14;
        final double radius = isTouched ? 60 : 50;
        final value = PieChartSectionData(
            color: data.color,
            value: data.percent,
            title: "${data.percent}%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white));
        return MapEntry(index, value);
      })
      .values
      .toList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(children: [
        AspectRatio(
            aspectRatio: 1,
            child: PieChart(PieChartData(
                pieTouchData: PieTouchData(touchCallback: (piet, value) {
                  //piet.touchedSection.
                })

                /*  PieTouchData(touchCallback: (event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),*/
                ,
                sections: getSections(touchedIndex),
                sectionsSpace: 1,
                borderData: FlBorderData(show: false))))
      ]),
    );
  }
}

class ChartData {
  final String name;
  final double percent;
  final Color color;
  final double value;
  ChartData(
      {required this.name,
      required this.percent,
      required this.color,
      required this.value});
}

List<ChartData> listChartData = [];

//Todo Put this in a controller
Future<void> loadExpenseChartData(String date, {String? month}) async {
  var expenseController = locator<ExpenseController>();
  var list = await expenseController.getSumByCategoryOfMonth(date);

  if (list != null) {
    if (list.isNotEmpty) {
      var totalOfMonth = await AppConfiguration.database!.expenseDao
          .getTotalAmountOfMonth(date);

      listChartData = [];

      print("Entrou... ${totalOfMonth}");

      list.forEach((element) {
        listChartData.add(ChartData(
            name: element.name,
            percent: ((element.value! / totalOfMonth!) * 100).roundToDouble(),
            color: HexColor.hexStringToColor("${element.color}"),
            value: element.value as double));
      });
    }
  }
}

//924012503

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kumbuz/configs/config.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';

class CategoryCard extends StatelessWidget {
  // const CategoryCard({Key? key}) : super(key: key);

  Category? category;
  int? index;
  //double? value;

  CategoryCard(this.category, this.index);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 2.5,
      height: size.width / 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index == 0 ? AppColors.primaryColor : Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 2))]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                width: 20,
                height: 20,
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: index == 0
                      ? Colors.white
                      : hexStringToColor(category!.color as String),
                )
                // child: SvgPicture.asset("${category!.iconUrl}",
                //     color: AppColors.primaryColor),
                ),
            SizedBox(
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${category!.name}",
                  style: TextStyle(
                      color: index == 0 ? Colors.white : Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${CurrencyFormatter.format(category!.value, GetIt.instance.get<CurrencyFormatterSettings>())}",
                  style: TextStyle(
                      fontSize: 16,
                      color: index == 0 ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  hexStringToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}

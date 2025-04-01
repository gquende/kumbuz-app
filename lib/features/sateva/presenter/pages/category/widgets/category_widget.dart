import 'package:flutter/material.dart';
import 'package:kumbuz/core/configs/theme/colors.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';

class CategoryWidget extends StatelessWidget {
  Category category;

  CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //const Icon(Icons.category),
            const SizedBox(
              width: 10,
            ),
            Text(
              category.name,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.edit,
                    color: PRIMARY_COLOR,
                  ),
                  onTap: () {
                    print("Clicked on edit ");
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: () {
                    print("Clicked on delete option ");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

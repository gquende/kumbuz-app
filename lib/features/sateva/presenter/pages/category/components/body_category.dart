import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/presenter/pages/category/widgets/category_widget.dart';

import '../../../../domain/entities/category.dart';

class BodyCategory extends StatelessWidget {
  List<Category> categories;

  BodyCategory({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: categories.map((element) {
          return CategoryWidget(category: element);
        }).toList(),
      ),
    );
  }
}

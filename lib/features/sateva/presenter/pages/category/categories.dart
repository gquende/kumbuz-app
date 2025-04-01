import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kumbuz/features/sateva/data/models/category_model.dart';
import 'package:kumbuz/features/sateva/domain/entities/category.dart';
import 'package:kumbuz/features/sateva/presenter/pages/category/controllers/category_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../../../app.dart';
import '../../../../../core/configs/config.dart';
import '../../../../../shared/presentation/ui/spacing.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  var controller = CategoryController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ContainedTabBarView(
          onChange: (value) {
            pageIndex = value;
            print(pageIndex);
          },
          tabs: [Text("Despesas"), Text("Receitas")],
          views: [
            FutureBuilder(
                future: controller.getAll(type: "expense"),
                builder: (ctx, snap) {
                  if (!snap.hasData) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    );
                  }

                  var listOfCategories = snap.data as List<CategoryModel>;
                  if (listOfCategories.isNotEmpty) {
                    return ListView.builder(
                      itemCount: listOfCategories.length,
                      itemBuilder: (ctx, index) {
                        return CategoryCard(listOfCategories[index]);
                      },
                    );
                  }
                  return const Center(
                    child: Text("Sem Categorias"),
                  );
                }),
            FutureBuilder(
                future: controller.getAll(type: "income"),
                builder: (ctx, snap) {
                  if (!snap.hasData) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    );
                  }

                  var listOfCategories = snap.data as List<CategoryModel>;
                  if (listOfCategories.isNotEmpty) {
                    return ListView.builder(
                      itemCount: listOfCategories.length,
                      itemBuilder: (ctx, index) {
                        return CategoryCard(listOfCategories[index]);
                      },
                    );
                  }
                  return const Center(
                    child: Text("Sem Categorias"),
                  );
                }),
          ],
          tabBarProperties: const TabBarProperties(
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: Colors.grey),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          debugPrint("Clicked on Add Category");
          await _addCategory(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _addCategory(BuildContext context) async {
    var size = MediaQuery.of(context).size;
    var isLoading = false.obs;
    double _distanceToField = size.width;
    var textEditingController = TextEditingController();

    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: TextField(
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      label: Text("Nome da categoria")),
                                )),

                            const Spacing.y(),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            GestureDetector(
                              onTap: () async {
                                isLoading.value = true;

                                if (textEditingController.text.isNotEmpty) {
                                  CategoryModel category = CategoryModel(
                                      0,
                                      Uuid().v4(),
                                      App.user!.uuId,
                                      textEditingController.text,
                                      "",
                                      "",
                                      0,
                                      pageIndex == 0 ? "expense" : "income");

                                  await controller.addCategory(category);
                                  setState(() {});
                                  Navigator.of(context).pop();
                                }
                                isLoading.value = false;
                              },
                              child: Container(
                                  width: size.width,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      boxShadow: const [
                                        BoxShadow(
                                            offset: Offset(0, 0),
                                            color: Colors.black12,
                                            spreadRadius: .7,
                                            blurRadius: 2)
                                      ],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Obx(() {
                                    return Center(
                                      child: isLoading.value
                                          ? const CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            )
                                          : const Text(
                                              "Adicionar",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    );
                                  })),
                            ),
                          ],
                        ))),
              ),
            ),
          );
        },
        barrierDismissible: !isLoading.value);

    return;
  }

  Widget CategoryCard(Category category) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: const BoxDecoration(
          // boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 1))],
          // borderRadius: BorderRadius.circular(8),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                category.iconUrl!.isEmpty
                    ? Icon(Icons.category)
                    : SvgPicture.asset(category.iconUrl as String),
                const SizedBox(
                  width: 10,
                ),
                Text(category.name),
              ],
            ),
            category.userId == "base"
                ? SizedBox()
                : Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await controller
                              .deleteCategory(category as CategoryModel);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

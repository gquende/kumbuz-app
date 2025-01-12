import '../../features/sateva/domain/entities/category.dart';

List<Category> GlobalExpenseCategoryList = [];
List<Category> ExpensePerCategoryGlobalList = [];
List<Category> IncomeCategoryList = [
  Category("", "", "Salário", "", "", 0, "income"),
  Category("", "", "Dividendos", "", "", 0, "income"),
  Category("", "", "Outros", "", "", 0, "income")
];
String calculatorResult = "";

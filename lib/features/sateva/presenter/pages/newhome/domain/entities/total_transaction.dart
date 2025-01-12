enum Type { income, expense }

class TotalTransaction {
  Type type;
  double? value;
  String? text;

  TotalTransaction.income({text, value}) : type = Type.income;
  TotalTransaction.expense({text, value}) : type = Type.expense;
}

class ExpenseEntity {
  String uuId;
  String walletId;
  double amount;
  String description;
  String category;
  String date;
  String time;
  bool recurring = false;
  String? periodyRecurring;

  ExpenseEntity(this.uuId, this.date, this.time, this.amount, this.description,
      this.category, this.walletId, this.recurring, this.periodyRecurring);
}

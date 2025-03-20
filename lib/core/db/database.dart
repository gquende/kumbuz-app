import 'dart:async';

import 'package:floor/floor.dart';
import 'package:kumbuz/features/sateva/data/models/budget.dart';
import 'package:kumbuz/features/sateva/data/models/category_model.dart';
import 'package:kumbuz/features/sateva/data/models/debt.dart';
import 'package:kumbuz/features/sateva/data/models/expense.dart';
import 'package:kumbuz/features/sateva/data/models/goals.dart';
import 'package:kumbuz/features/sateva/data/models/income.dart';
import 'package:kumbuz/features/sateva/data/models/user.dart';
import 'package:kumbuz/features/sateva/data/models/wallet.dart';
import 'package:kumbuz/features/sateva/data/models/wallet_transaction.dart';
import 'package:kumbuz/features/sateva/data/repositories/categoryImpl.dart';
import 'package:kumbuz/features/sateva/data/repositories/dao/budget_dao.dart';
import 'package:kumbuz/features/sateva/data/repositories/dao/debt_dao.dart';
import 'package:kumbuz/features/sateva/data/repositories/dao/expense_dao.dart';
import 'package:kumbuz/features/sateva/data/repositories/dao/goals_dao.dart';
import 'package:kumbuz/features/sateva/data/repositories/dao/income_dao.dart';
import 'package:kumbuz/features/sateva/data/repositories/dao/user_dao.dart';
import 'package:kumbuz/features/sateva/data/repositories/dao/wallet_dao.dart';
import 'package:kumbuz/features/sateva/data/repositories/dao/wallet_transaction_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [
  Income,
  User,
  Wallet,
  WalletTransaction,
  Income,
  Budget,
  CategoryModel,
  Goals,
  Debt
])
abstract class AppDatabase extends FloorDatabase {
  IncomeDao get incomeDao;
  ExpenseDao get expenseDao;
  UserDao get userDao;
  WalletDao get walletDao;
  WalletTransactionDao get walletTransactionDao;
  BudgetDao get budgetDao;
  CategoryImpl get categoryDao;
  GoalsDAO get goalsDao;
  DebtDao get debtDao;
}

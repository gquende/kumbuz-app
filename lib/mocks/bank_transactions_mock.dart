import 'package:flutter/material.dart';
import 'package:kumbuz/features/sateva/domain/entities/bank_transaction.dart';
import 'package:uuid/uuid.dart';

import '../utils/datetime_manipulation.dart';

// var bankTransactionMock = [
//   WalletTransaction(
//       Uuid().v4(),
//       "Casa da era",
//       Uuid().v4(),
//       Uuid().v4(),
//       2000,
//       "expense",
//       DateTime.now().toString(),
//       DateTime.now().toString(),
//       DateTime.now().toString(),
//       DateTime.now().toString()),
//   WalletTransaction(
//       Uuid().v4(),
//       "Kiala Shop",
//       Uuid().v4(),
//       Uuid().v4(),
//       2000,
//       "income",
//       DateTime.now().toString(),
//       DateTime.now().toString(),
//       DateTime.now().toString(),
//       DateTime.now().toString()),
//   WalletTransaction(
//       Uuid().v4(),
//       "Morgan Shop",
//       Uuid().v4(),
//       Uuid().v4(),
//       2000,
//       "expense",
//       DateTime.now().toString(),
//       DateTime.now().toString(),
//       DateTime.now().toString(),
//       DateTime.now().toString()),
// ];

var bankTransactionsMock = <BankTransaction>[
  BankTransaction(
      Uuid().v4(),
      "description 1",
      Uuid().v4(),
      Uuid().v4(),
      4000,
      "expense",
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      TimeOfDay.now().toString(),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now()),
      DateTimeManipulation.getFormatDateForSQLite(DateTime.now())),
  BankTransaction(
      Uuid().v4(),
      "description 2",
      Uuid().v4(),
      Uuid().v4(),
      4000,
      "income",
      DateTime.now().toString(),
      DateTime.now().toString(),
      DateTime.now().toString(),
      DateTime.now().toString()),
  BankTransaction(
      Uuid().v4(),
      "description 3",
      Uuid().v4(),
      Uuid().v4(),
      4000,
      "expense",
      DateTime.now().toString(),
      DateTime.now().toString(),
      DateTime.now().toString(),
      DateTime.now().toString())
];

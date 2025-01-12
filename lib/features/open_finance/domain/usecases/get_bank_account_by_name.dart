import 'dart:developer';

import 'package:kumbuz/features/sateva/data/models/bank_account.dart';

import '../repository/i_bank_repository.dart';

class GetBankAccountByName {
  IBankRepository _repository;
  GetBankAccountByName(IBankRepository repo) : _repository = repo;

  Future<BankAccount?> handle(String name) async {
    try {
      return _repository.getBankByName(name);
    } catch (error) {
      log("Error : ${error.toString()}");
    }

    return null;
  }
}

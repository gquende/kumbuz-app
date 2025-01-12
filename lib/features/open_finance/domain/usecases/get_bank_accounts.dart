import 'dart:developer';

import 'package:kumbuz/features/sateva/data/models/bank_account.dart';

import '../repository/i_bank_repository.dart';

class GetBankAccounts {
  IBankRepository _repository;
  GetBankAccounts(IBankRepository repo) : _repository = repo;

  Future<List<BankAccount>> handle(String userId) async {
    try {
      return _repository.getAll(userId);
    } catch (error) {
      log("Error : ${error.toString()}");
    }

    return [];
  }
}

import '../../../sateva/data/models/bank_account.dart';
import '../repository/i_bank_repository.dart';

class SaveBankAccount {
  IBankRepository _repository;

  SaveBankAccount(IBankRepository repo) : _repository = repo;

  Future<dynamic> handle(BankAccount _bankAccount) async {
    return await _repository.insert(_bankAccount);
  }
}

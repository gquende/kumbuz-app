import '../../data/models/wallet_transaction.dart';

class BankTransaction extends WalletTransaction {
  BankTransaction(
      super.uuId,
      super.description,
      super.walletId,
      super.itemId,
      super.amount,
      super.type,
      super.date,
      super.time,
      super.createAt,
      super.updateAt);
}

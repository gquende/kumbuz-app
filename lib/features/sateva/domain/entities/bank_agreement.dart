import 'package:equatable/equatable.dart';

class BankAgreement extends Equatable {
  String? uuid;
  int? max_historical_days;
  int? access_valid_for_days;
  String? institution_id;

  BankAgreement({
    this.max_historical_days,
    this.access_valid_for_days,
    this.institution_id,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      throw [uuid, max_historical_days, access_valid_for_days, institution_id];
}

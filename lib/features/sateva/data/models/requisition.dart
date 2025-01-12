import 'package:kumbuz/features/sateva/domain/entities/requisition.dart';

class Requisition extends IRequisition {
  Requisition(
      {required String uuid,
      required String link,
      required String agreementId,
      required String reference,
      required List accounts})
      : super(
            uuid: uuid,
            agreementId: agreementId,
            link: link,
            reference: reference,
            accounts: accounts);
}
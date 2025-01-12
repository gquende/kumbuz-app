class IRequisition {
  String uuid;
  String link;
  String agreementId;
  String reference;
  List accounts;

  IRequisition(
      {required this.uuid,
      required this.link,
      required this.agreementId,
      required this.reference,
      required this.accounts});
}
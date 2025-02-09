import '../../../../services/nordigen_service.dart';

class ConnectAccountUsecase {
  List<String>? _accountsConnected;
  final String INSTITUTION_ID;
  NordigenClient _client;

  ConnectAccountUsecase(this._client, this.INSTITUTION_ID) {
    _accountsConnected = [];
  }

  List? get accountsConnected => _accountsConnected;

  Future<Map<dynamic, dynamic>?> handler(String redirectUrl) async {
    var metadata = await _client.initSession(
        institutionId: INSTITUTION_ID, redirectUrl: redirectUrl);
    Map? requesitionMetadata;

    if (metadata != null) {
      var requesitions = metadata['results'] as List;
      if (requesitions != null) {
        for (int i = 0; i < requesitions.length; i++) {
          if ((requesitions[i]['accounts'] as List).length > 0) {
            (requesitions[i]['accounts'] as List).forEach((element) {
              _accountsConnected!.add(element as String);
            });

            requesitionMetadata = requesitions[i] as Map;
            break;
          }
        }
        return requesitionMetadata;
      }
      return null;
    }

    return null;
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class NordigenClient {
  String _endpoint = "token";
  final String secret_id;
  final String secret_key;
  final String _base_url = "https://ob.nordigen.com/api/v2";
  String? _token;
  Map<String, String>? _headers;
  InstitutionApi? institution;
  AgreementApi? agreement;
  RequisitionsApi? requisition;
  //AccountApi? account;
  // String? _REFRESH_USER_TOKEN;
  //Map<String, Uri>? _endpoints;

  get token => this._token;
  set token(dynamic newToken) {
    this._token = newToken;
    this._headers!['Authorization'] = 'Bearer ${token}';
  }

  NordigenClient({required this.secret_id, required this.secret_key}) {
    this._headers = {
      "accept": "application/json",
      //"Content-Type": "application/json",
      "User-Agent": "Nordigen-Node-v2"
    };
    // generateToken().whenComplete(() => {
    //
    // })\

    institution = InstitutionApi(client: this);
    agreement = AgreementApi(client: this);
    requisition = RequisitionsApi(client: this);
  }

  Future<AccountApi> account({accountId}) async {
    if (_token == null) await generateToken();
    return AccountApi(client: this, accountId: accountId);
  }

  Future<Object?> request(
      {String? endpoint,
      Map<dynamic, dynamic>? parameters = const {},
      String method = "GET"}) async {
    Uri url = Uri.parse("${this._base_url}/${endpoint}");
    // request()
    var request = http.Request(method, url);
    request.headers.addAll(_headers as Map<String, String>);

    http.Response? response;

    switch (method) {
      case "GET":
        {
          response = await http.get(url, headers: this._headers);
          break;
        }
      case "POST":
        {
          response =
              await http.post(url, headers: this._headers, body: parameters);

          break;
        }
      case "DELETE":
        {
          response =
              await http.delete(url, headers: this._headers, body: parameters);
          break;
        }
      case "PUT":
        {
          response =
              await http.put(url, headers: this._headers, body: parameters);
          break;
        }
    }

    return jsonDecode(response!.body);
  }

  Future<Map<String, dynamic>> generateToken() async {
    var payload = {"secret_key": this.secret_key, "secret_id": this.secret_id};

    var map = await this.request(
        endpoint: "${this._endpoint}/new/",
        parameters: payload,
        method: "POST") as Map<String, dynamic>;

    this._headers!["Authorization"] = "Bearer ${map['access']}";
    return map;
  }

  Future<Map<String, dynamic>> refreshToken(
      {required String refreshToken}) async {
    var payload = {
      "refresh": refreshToken,
    };
    return await this.request(
        endpoint: "${this._endpoint}/refresh/",
        parameters: payload,
        method: "POST") as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> initSession(
      {redirectUrl,
      institutionId,
      referenceId = "124151",
      maxHistoricalDays = 90}) async {
    var agreement = await this.agreement!.createAgreement(
        institutionId: institutionId, maxHistoricalDays: maxHistoricalDays);

    return await this.requisition!.createRequisition(
        redirectUrl: redirectUrl,
        institutionId: institutionId,
        reference: referenceId,
        agreement: agreement.id);
  }
}

class AccountApi {
  String endpoint = "accounts";
  NordigenClient? client;
  String? accountId;
  AccountApi({this.client, this.accountId});

  Future<Map<String, dynamic>> getAccount(
      {required String path, Map<String, String> parameters = const {}}) async {
    String url = "${endpoint}/${this.accountId}/${path}";

    return await this.client!.request(endpoint: url, method: "GET")
        as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getPremium(
      {required String path, Map<String, String> parameters = const {}}) async {
    String url = "${endpoint}/premium/${this.accountId}/${path}";
    return await this.client!.request(
        endpoint: url,
        parameters: parameters,
        method: "GET") as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getMetadata() async {
    String url = "${endpoint}/${this.accountId}";
    return await this.client!.request(
        endpoint: url, parameters: {}, method: "GET") as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getDetails() async {
    return this.getAccount(path: "details");
  }

  Future<Map<String, dynamic>> getPremiumDetails() async {
    return this.getPremium(path: "details");
  }

  Future<Map<String, dynamic>> getBalances() async {
    return this.getAccount(path: "balances");
  }

  Future<Map<String, dynamic>> getTransactions(
      {required String dateFrom, required String dateTo}) async {
    var dateRange = {"date_from": dateFrom, "date_to": dateTo};
    return this.getAccount(path: "transactions", parameters: dateRange);
  }

  Future<Map<String, dynamic>> getPremiumTransactions(
      {required String dateFrom, required String dateTo}) async {
    var dateRange = {"date_from": dateFrom, "date_to": dateTo};
    return this.getPremium(path: "transactions", parameters: dateRange);
  }
}

class InstitutionApi {
  String _endpoint = "institutions";
  NordigenClient? client;
  InstitutionApi({this.client});

  Future<List<dynamic>> getInstitutions({required String country}) async {
    var url = "${this._endpoint}/?country=$country";
    return await this.client!.request(endpoint: url) as List<dynamic>;
  }

  Future<Map<String, dynamic>> getInstitutionById({required String id}) async {
    var url = "${this._endpoint}/$id/";
    return await this.client!.request(endpoint: url) as Map<String, dynamic>;
  }
}

class AgreementApi {
  String _endpoint = "agreements/enduser";
  NordigenClient? client;
  AgreementApi({this.client});

  Future<NordigenAgreement> createAgreement(
      {required String institutionId,
      required int maxHistoricalDays,
      int accessValidForDays = 90,
      List<String> accessScope = const [
        "balances",
        "details",
        "transactions"
      ]}) async {
    var payload = {
      "institution_id": institutionId,
      "max_historical_days": "$maxHistoricalDays",
      "access_valid_for_days": "$accessValidForDays",
    };
    var map = await client!.request(
        endpoint: "${_endpoint}/",
        parameters: payload,
        method: "GET") as Map<String, dynamic>;

    var internalList = map['results'];

    NordigenAgreement agreement = NordigenAgreement(
        id: map['id'],
        max_historical_days: map['max_historical_days'],
        access_valid_for_days: map['access_valid_for_days'],
        institution_id: map['institution_id'],
        access_scope: ['access_scope'],
        accepted: map['accepted']);
    return agreement;
  }

  Future<Map<String, dynamic>> getAgreements(
      {int limit = 100, int offset = 0}) async {
    var params = {
      "limit": limit,
      "offset": offset,
    };
    return await this.client!.request(
        endpoint: "${this._endpoint}/",
        parameters: params) as Map<String, dynamic>;
  }

  // Future<Map<String, dynamic>> getAgreementById(
  //     {required String agreementId}) async {
  //   return await this
  //       .client!
  //       .request(endpoint: "${this._endpoint}/$agreementId");
  // }

  // Future<Map<String, dynamic>> acceptAgreements(
  //     {required String agreementId,
  //     required String ip,
  //     required String userAgent}) async {
  //   var params = {
  //     "user_agent": userAgent,
  //     "ip_address": ip,
  //   };
  //   return await this.client!.request(
  //       endpoint: "${this._endpoint}/$agreementId/accept/",
  //       parameters: params,
  //       method: "PUT");
  // }
}

class RequisitionsApi {
  String _endpoint = "requisitions";
  NordigenClient? client;

  RequisitionsApi({this.client});

  Future<Map<String, dynamic>> createRequisition(
      {String? redirectUrl,
      String? institutionId,
      String? agreement,
      String? userLanguage,
      String? reference}) async {
    //TODO refactor this when i undestant how some sentences work
    var payload = {
      "redirect": redirectUrl,
      "reference": reference,
      "institution_id": institutionId,
      "user_language": userLanguage ?? "en",
      "agreement": agreement ?? "",
    };

    await this.client!.generateToken();
    return await this.client!.request(
        endpoint: "${this._endpoint}/",
        parameters: payload,
        method: "GET") as Map<String, dynamic>;
  }

  // Future<Map<String, dynamic>> getRequisitions(
  //     {int limit = 100, int offset = 0}) async {
  //   var params = {
  //     "limit": limit,
  //     "offset": offset,
  //   };
  //   return await this.client!.request(
  //       endpoint: "${this._endpoint}/", parameters: params, method: "GET");
  // }

  Future<Map<String, dynamic>> getRequisitionsById(
      {required String requisitionId}) async {
    return await this.client!.request(
        endpoint: "${this._endpoint}/$requisitionId/") as Map<String, dynamic>;
  }

  // Future<Map<String, dynamic>> deleteRequisitions(
  //     {required String requisitionId}) async {
  //   return await this.client!.request(
  //       endpoint: "${this._endpoint}/$requisitionId/", method: "DELETE");
  // }
}

class NordigenAgreement {
  String? id;
  int? max_historical_days;
  int? access_valid_for_days;
  String? institution_id;
  List<String>? access_scope;
  String? accepted;

  NordigenAgreement(
      {this.id,
      this.max_historical_days,
      this.access_valid_for_days,
      this.institution_id,
      this.access_scope,
      this.accepted});
}

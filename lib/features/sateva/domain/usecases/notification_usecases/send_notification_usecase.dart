import '../../../../../services/one_signal_service.dart';

class SendNotificationUsecase {
  late OneSignalService _service;

  SendNotificationUsecase(OneSignalService service) : _service = service;

  Future<void> send(Map<String, dynamic> data) async {
    var result = await _service.request(body: data);
  }
}

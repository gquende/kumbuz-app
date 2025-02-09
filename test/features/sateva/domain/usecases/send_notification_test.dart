import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/features/sateva/domain/usecases/notification_usecases/send_notification_usecase.dart';
import 'package:kumbuz/services/one_signal_service.dart';

main() {
  // ONESIGNAL_APP_ID="97d3e02b-2259-437a-9251-e1559f34d71c"
  // ONESIGNAL_API_KEY="YTI2OWNjNDMtYjZhNy00MjViLWIwNzUtM2E2OThhMTAwMzky"

  OneSignalService service = OneSignalService(
      APP_KEY: "97d3e02b-2259-437a-9251-e1559734d71c",
      API_KEY: "YTI2OWNjNDMtYjZhNy00MjViLWIwN04UtM2E2OThhMTAwMzky");

  SendNotificationUsecase usecase = SendNotificationUsecase(service);

  test("Send Notification", () async {
    var data = {
      "target_channel": "push",
      "contents": {"en": "English Message", "es": "Spanish Message"},
      "include_aliases": {
        "external_id": [
          "madalfo",
        ]
      }
    };

    var result = await usecase.send(data);
    expect(2, 2);
  });
}

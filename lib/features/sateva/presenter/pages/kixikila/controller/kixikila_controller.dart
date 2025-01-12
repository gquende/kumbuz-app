import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kumbuz/core/di/dependecy_injection.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';
import 'package:kumbuz/core/utils/strings_utils.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_guest.dart';
import 'package:kumbuz/features/sateva/domain/entities/kixikila/kixikila_payment.dart';
import 'package:kumbuz/features/sateva/domain/usecases/kixikila_usecases/guests/get_all_usecase.dart';
import 'package:kumbuz/features/sateva/domain/usecases/kixikila_usecases/payments/get_all_usecase.dart';
import 'package:kumbuz/main.dart';
import 'package:kumbuz/mocks/kixikila_guests_mock.dart';
import 'package:kumbuz/mocks/kixikilas_mock.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../app.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/kixikila_usecases/guests/insert_usecase.dart';
import '../../../../domain/usecases/kixikila_usecases/guests/update_usecase.dart';
import '../../../../domain/usecases/kixikila_usecases/kixikila_get_all_usecase.dart';
import '../../../../domain/usecases/kixikila_usecases/kixikila_insert_in_guest_usecase.dart';
import '../../../../domain/usecases/kixikila_usecases/kixikila_insert_usecase.dart';
import '../../../../domain/usecases/kixikila_usecases/payments/insert_usecase.dart';
import '../../../../domain/usecases/notification_usecases/send_notification_usecase.dart';
import '../../../../domain/usecases/user_usecases/user_get_by_id_usecase.dart';

class KixikilaController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String paymentMethod = "inicio";

  var invitedUsers = <KixikilaGuest>[].obs;
  var guestsOfKixikila = <String>[];

  var kixikilas = <Kixikila>[].obs;

  GlobalKey<FormState> formKey = GlobalKey();

  var loading = false.obs;

  Future<int> insert(Kixikila kixikila) async {
    loading.value = true;
    var usecase = DI.get<KixikilaInsertUsecase>();
    int result = await usecase.handle(kixikila);
    loading.value = false;
    return result;
  }

  Future<int> createKixikila(
      String userId, List<KixikilaGuest> guests, BuildContext context) async {
    try {
      if (_checkData()) {
        loading.value = true;

        print("Outro user...");
        print("${App.user?.uuId}");

        Kixikila kixikila = Kixikila(
            description: descriptionController.text,
            paymentDate: paymentMethod,
            status: "open",
            createdBy: App.user?.uuId ?? "",
            amount: double.parse(amountController.text),
            createdAt: DateTime.now().toString(),
            updatedAt: DateTime.now().toString());

        var usecase = DI.get<KixikilaInsertUsecase>();
        int result = await usecase.handle(kixikila);

        if (result == 1) {
          //Add Current user like a first user
          guests.add(KixikilaGuest(
              kixikilaId: kixikila.id as String,
              userId: userId,
              paymentSequence: 1,
              user: "${App.user?.name} ${App.user?.surname}",
              lastPaymentDate: "",
              status: "accept"));

          //Update KixikilaId on your guests
          guests.forEach((value) {
            value.kixikilaId = kixikila.id as String;
            print("GUESTTTT ${value.userId}");

            DI
                .get<KixikilaInsertInTheGuestUsecase>()
                .handle(guestId: value.userId, kixiID: kixikila.id as String);
          });
          var insertInvitedUserUsecase = DI.get<KixikilaGuestInsertUsecase>();

          result = await insertInvitedUserUsecase.handle(guests);

          if (result == 1) {
            var notificationUsecase = DI.get<SendNotificationUsecase>();

            for (var guest in guests) {
              DI.get<UserGetByIdUsecase>().handle(guest.userId).then((value) {
                var user = UserEntity.fromJson(value?["data"]);

                print("SENDING NOT TO:: ${user.notificationDeviceId}");

                var data = {
                  "target_channel": "push",
                  "contents": {
                    "en":
                        "O (a) ${App.user?.name} convidou-lhe para entrar na kixikila ${kixikila.description}",
                    "pt":
                        "O (a) ${App.user?.name} convidou-lhe para entrar na kixikila ${kixikila.description}",
                    "es": "Spanish Message"
                  },
                  "include_aliases": {
                    "onesignal_id": [user.notificationDeviceId ?? ""]
                  }
                };
                notificationUsecase.send(data);
              });
            }
          }

          print("Resultado ao inserir convidados:: $result");
        }

        await getAll();
        loading.value = false;
        guestsOfKixikila.clear();

        return result;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Insere todos os campos...")));
      }
    } catch (error) {
      debugPrint("KixikilaController:: Insert Error:: ${error.toString()}");
    }
    return 0;
  }

  Future<List<Kixikila>> getAll() async {
    try {
      loading.value = true;

      var userId = App.user?.uuId ?? "";

      //kixikilas.value = kixikilas_list_mock;
      var usecase = DI.get<KixikilaGetAllUsecase>();

      kixikilas.value = await usecase.handle(userId);
      loading.value = false;
      return kixikilas;
    } catch (error) {
      debugPrint("KixikilaController:: CreateKixikila:: ${error.toString()}");
    }
    loading.value = false;
    return [];
  }

  Future<List<KixikilaGuest>> getUsersByKixikila(String id) async {
    return [];
  }

  bool _checkData() {
    return amountController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty;
  }

  void resetForm() {
    amountController.text = "";
    descriptionController.text = "";
  }

  Future<List<KixikilaGuest>> getGuests(String? id) async {
    try {
      loading.value = true;
      //var data = kixikilaGuestMock;

      var usecaseGetGuests = DI.get<KixikilaGuestGetAllUsecase>();

      var data = await usecaseGetGuests.handle(id as String);

      loading.value = false;
      return data;
    } catch (error) {
      loading.value = false;
      if (kDebugMode) {
        print(error);
      }
    }

    return [];
  }

  Future<bool> payKixikila(KixikilaGuest guest, double amount) async {
    try {
      await Future.delayed(Duration(seconds: 3));

      KixikilaPayment payment = KixikilaPayment(
          id: Uuid().v4(),
          kixikilaId: guest.kixikilaId,
          userId: App.user?.uuId ?? "",
          amount: amount,
          userName: App.user!.name + " " + App.user!.surname,
          status: "pending",
          paymentDate: DateTime.now().toString());

      var payUsecase = DI.get<KixikilaPaymentInsertUsecase>();

      var result = await payUsecase.handle(payment);

      if (result == 1) {
        var guestUpdateUsecase = DI.get<KixikilaGuestUpdateUsecase>();

        guest.lastPaymentDate = DateTime.now().toString();

        return await guestUpdateUsecase.handle(guest) == 1;
      }

      return false;
    } catch (error) {
      debugPrint("KixikilaCotroller:: PayKixikila ${error.toString()}");
    }
    return false;
  }

  Future<void> invitingUser(String username, BuildContext context) async {
    try {
      var getUserUsecase = DI.get<UserGetByIdUsecase>();

      var userHashId = hashData(username);

      var data = await getUserUsecase.handle(userHashId);

      if (data == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Uilizador não encontrado"),
          backgroundColor: Colors.amber,
        ));
      } else {
        int paymentSequence = invitedUsers.length + 2;

        print("Position:: ${paymentSequence}");
        guestsOfKixikila.add(username);
        KixikilaGuest guest = KixikilaGuest(
            kixikilaId: "",
            userId: data["data"]["id"],
            user: "${data["data"]["name"]} ${data["data"]["surname"]}",
            paymentSequence: paymentSequence,
            lastPaymentDate: "",
            status: "invited");

        bool invited =
            invitedUsers.value.any((value) => value.userId == guest.userId);

        if (invited) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Este utilizador já foi convidado..."),
            backgroundColor: Colors.red,
          ));
        } else {
          invitedUsers.add(guest);
          //  Navigator.of(context).pop();
        }
      }
    } catch (error, st) {
      errorLog(error, st);
    }
  }

  void removeGuest(String username) {
    guestsOfKixikila.remove(username);
    invitedUsers.value = invitedUsers.value
        .where((value) => value.userId != hashData(username))
        .toList();
  }
}

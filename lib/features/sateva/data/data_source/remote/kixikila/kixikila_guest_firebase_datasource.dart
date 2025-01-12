import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../../../../domain/entities/kixikila/kixikila_guest.dart';

class KixikilaGuestRemoteDataSource {
  static final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<bool> insert(List<KixikilaGuest> guests) async {
    try {
      bool result = false;
      String kixikilaId = guests[0].kixikilaId;

      //Create map by payment sequence of user
      var map = Map();

      for (var user in guests) {
        await database
            .ref("kixikilas")
            .child(kixikilaId)
            .child("guests")
            .child("${user.paymentSequence}")
            .set(user.toJson());
      }

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<List<Object?>> getUsersInvited(String kixikilaId) async {
    List<Object?> usersInvited = [];
    try {
      var data = await database
          .ref("kixikilas")
          .child(kixikilaId)
          .child("guests")
          .get();

      print("Getting Users Inveteds");
      usersInvited = data.value as List<Object?>;
      print(usersInvited);
    } catch (error) {
      print(error);
      return usersInvited;
    } finally {
      return usersInvited;
    }
  }

  Future<bool> update(Map<String, dynamic> guest) async {
    try {
      await database
          .ref("kixikilas")
          .child(guest["kixikilaId"])
          .child("guests")
          .child("${guest["paymentSequence"]}")
          .update(guest);
      return true;
    } catch (error) {
      debugPrint(
          "KixikilaGuestRemoteDataSource:: update :: ${error.toString()}");

      return false;
    }
  }
}

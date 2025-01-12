import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class KixikilaRemoteDataSource {
  static final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<bool> insert(Map<String, dynamic> kixikila) async {
    try {
      database
          .ref("kixikilas")
          .child(kixikila["id"])
          .child("data")
          .set(kixikila)
          .then((value) {
        database
            .ref("users")
            .child(kixikila["createdBy"])
            .child("kixikilas")
            .child(kixikila["id"])
            .set(kixikila["id"]);
      }).onError((error, stackTrace) {
        print(error.toString());
      });
      return true;
    } catch (error) {
      debugPrint("ERROR TO INSERT KIXI:: ${error.toString()}");
      return false;
    }
  }

  Future<bool> insertInTheGuest(
      {required String guestId, required String kixikilaId}) async {
    try {
      database
          .ref("users")
          .child(guestId)
          .child("kixikilas")
          .child(kixikilaId)
          .set(kixikilaId)
          .onError((error, stackTrace) {
        print(error.toString());
      });
      return true;
    } catch (error) {
      debugPrint("ERROR TO INSERT KIXI:: ${error.toString()}");
      return false;
    }
  }

  Future<List<Map>> getKixikilas(String userUUID) async {
    List<Map> kixikilas = [];
    try {
      var result =
          await database.ref("users").child(userUUID).child("kixikilas").get();
      var data = result.value as Map;
      var kixikilasIds = data.keys;

      for (var id in kixikilasIds) {
        var snap = await database.ref("kixikilas").child(id).get();
        var kixikila = snap.value as Map;
        kixikilas.add(kixikila);
      }

      return kixikilas;
    } catch (error) {
      return kixikilas;
    }
  }

  Future<bool> updateKixikila(Map<String, dynamic> kixikila) async {
    try {
      database
          .ref("kixikilas")
          .child(kixikila["id"])
          .update(kixikila)
          .then((value) {});

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> deleteKixikila(Map<String, dynamic> kixikila) async {
    try {
      database.ref("kixikilas").child(kixikila["id"]).remove().then((value) {});

      return true;
    } catch (error) {
      return false;
    }
  }
}

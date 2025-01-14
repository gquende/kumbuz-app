import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kumbuz/core/error/log/catch_error_log.dart';

class UserRemoteDataSource {
  static final FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> create(Map<String, dynamic> userData) async {
    try {
      bool result = false;

      print("Entrei no remote:: data:: ${userData}");

      var credentials = await auth.createUserWithEmailAndPassword(
        email: userData["username"],
        password: userData["password"],
      );

      // var credentials = await auth.signInWithEmailAndPassword(
      //   email: userData["username"],
      //   password: userData["password"],
      // );

      print("Sai do codigo...");
      //var messageToken = await messaging.getToken();
      //print("Token: ${messageToken}");
      print("User: ${credentials.user?.uid}");
      userData["password"] = null;
      //userData["id"] = credentials.user?.uid ?? userData["id"];
      database
          .ref("users")
          .child(userData["id"])
          .child("data")
          .set(userData)
          .then((value) {
        // database
        //     .ref("notification_tokens")
        //     .child(userData["id"])
        //     .set(messageToken);
      }).onError((error, stackTrace) {
        print(error.toString());
      });

      return credentials;
    } catch (error, stackTrace) {
      errorLog(error, stackTrace);

      return null;
    }
  }

  Future<bool> update(Map<String, dynamic> userData) async {
    try {
      bool result = false;

      print(userData);

      await database
          .ref("users")
          .child(userData["id"])
          .child("data")
          .update(userData);

      return result;
    } catch (error) {
      return false;
    }
  }

  Future<dynamic> getById(String id) async {
    try {
      //var messageToken = await messaging.getToken();

      var data = await database.ref("users").child(id).get();

      return data.value;
    } catch (error) {
      return null;
    }
  }
}

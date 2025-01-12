import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kumbuz/features/sateva/data/data_source/remote/i_remote_datasource.dart';

class FirebaseDataSourse implements IRemoteDataSource {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
}

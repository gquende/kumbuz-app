import 'package:flutter_test/flutter_test.dart';
import 'package:kumbuz/core/db/database.dart';
import 'package:kumbuz/features/sateva/data/repositories/notification_repository.dart';
import 'package:kumbuz/features/sateva/domain/entities/notification.dart';
import 'package:uuid/uuid.dart';

main() {
  late NotificationRepository _repository;

  setUp(() async {
    var database = await $FloorAppDatabase.databaseBuilder("app2.db").build();
    _repository = NotificationRepository(database);
  });

  test("Insert Notifitication", () async {
    var not = NotificationEntity(
        id: Uuid().v4(),
        title: "title",
        message: "message",
        dateTime: DateTime.now(),
        status: "noread");

    var result = await _repository.insert(not);

    expect(result != 0, true);
  });

  test("update Notifitication", () async {
    var not = NotificationEntity(
        id: Uuid().v4(),
        title: "title",
        message: "message",
        dateTime: DateTime.now(),
        status: "noread");

    var result = await _repository.insert(not);
    not.title = "Adolfo Quende";

    result = await _repository.update(not);

    expect(result != 0, true);
  });

  test("delete Notifitication", () async {
    var not = NotificationEntity(
        id: Uuid().v4(),
        title: "title",
        message: "message",
        dateTime: DateTime.now(),
        status: "noread");

    var result = await _repository.insert(not);
    result = await _repository.delete(not);

    print(result);
    expect(result != 0, true);
  });

  test("Get Notifitication", () async {
    var not = NotificationEntity(
        id: Uuid().v4(),
        title: "title",
        message: "message",
        dateTime: DateTime.now(),
        status: "noread");

    var not2 = NotificationEntity(
        id: Uuid().v4(),
        title: "title2",
        message: "message2",
        dateTime: DateTime.now(),
        status: "noread");

    await _repository.insert(not);
    await _repository.insert(not2);

    var list = await _repository.getAll();

    expect(list.isNotEmpty, true);
  });
}

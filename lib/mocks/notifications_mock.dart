import 'package:kumbuz/features/sateva/domain/entities/notification.dart';

var notificationsMock = [
  NotificationEntity(
      id: "1",
      title: "Poupança alcançada!",
      message:
          "Você economizou 120 000,00 Kzs este mês e atingiu sua meta de poupar para as férias",
      dateTime: DateTime.now(),
      status: "noread"),
  NotificationEntity(
      id: "2",
      title: "Seu orçamento está 80%",
      message:
          "O seu orçamento da categoria 'Lazer' está preste a exceder. Revise seus gastos antes que saia do controlo",
      dateTime: DateTime.now(),
      status: "noread"),
  // NotificationEntity(
  //     idContent: "3",
  //     message: "Verifica as dívidas",
  //     title: "Nova transacção adicionada",
  //     dateTime: DateTime.now(),
  //     status: "noread"),
  // NotificationEntity(
  //     idContent: "4",
  //     message: "Recebeu uma nova transacção do banco IU",
  //     title: "Nova transacção adicionada",
  //     dateTime: DateTime.now(),
  //     status: "read"),
];

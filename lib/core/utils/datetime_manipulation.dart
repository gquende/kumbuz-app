import 'package:date_format/date_format.dart';

class DateTimeManipulation {
  static String getDateOfPreviousMonth(DateTime date) {
    return formatDate(
        DateTime(date.year, date.month - 1, 1), [yyyy, '-', mm, '-', dd]);
  }

  static String getDateOfFowardMonth(DateTime date) {
    return formatDate(
        DateTime(date.year, date.month + 1, 1), [yyyy, '-', mm, '-', dd]);
  }

  static String getDateOfTheLastDayOfMonth(DateTime date) {
    return formatDate(
        DateTime(date.year, date.month + 1, 0), [yyyy, '-', mm, '-', dd]);
  }

  static String getDateOfTheFirstDayOfMonth(DateTime date) {
    return formatDate(
        DateTime(date.year, date.month, 1), [yyyy, '-', mm, '-', dd]);
  }

  static String getFormatDateForSQLite(DateTime date) {
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
  }

  static String getYearAndMonthForSQliteFormat(DateTime date) {
    return formatDate(date, [yyyy, '-', mm]);
  }

  static DateTime getDate(String date) {
    return DateTime.parse(date);
    // formatDate(date, formats)
  }

  static getWeekDayName(int weekday) {
    switch (weekday) {
      case 0:
        return "Domingo";
      case 1:
        return "Segunda-Feira";
      case 2:
        return "Terça-Feira";
      case 3:
        return "Quarta-Feira";
      case 4:
        return "Quinta-Feira";
      case 5:
        return "Sexta-Feira";
      case 6:
        return "Sábado";
    }
  }

  static getMonthName(int month) {
    switch (month) {
      case 1:
        return "Janeiro";
      case 2:
        return "Fevereiro";
      case 3:
        return "Março";
      case 4:
        return "Abril";
      case 5:
        return "Maio";
      case 6:
        return "Junho";
      case 7:
        return "Julho";
      case 8:
        return "Agosto";
      case 9:
        return "Setembro";
      case 10:
        return "Outubro";
      case 11:
        return "Novembro";
      case 12:
        return "Dezembro";
    }
  }

  String getDataByTypePayment(String type) {
    switch (type) {
      case "inicio":
        {
          if (DateTime.now().day > 15) {
            return getDateOfFowardMonth(DateTime.now());
          } else {
            return getDateOfTheFirstDayOfMonth(DateTime.now());
          }
        }
      case "fim":
        {
          return getDateOfTheLastDayOfMonth(DateTime.now());
        }
    }

    return "";
  }
}

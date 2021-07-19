import 'package:intl/intl.dart';

class DateHelper {
  static const String hoursWithMinutes = 'HH:mm';
  static const String digitMonth = 'dd.MM.yyyy';
  static const String stringMonth = 'dd MMM yyyy';


  static String getFormattedString({
    required DateTime date,
    required String datePattern,
    required String countryCode,
  }) {
    return DateFormat(datePattern, countryCode).format(date);
  }

  static DateTime getDateFromString({required String date}) {
//TODO: доделать форматирование строки в дату из формата dd.mm.yyyy
    return DateTime.parse(date);
  }
}

import 'package:intl/intl.dart';

class DateHelper {
  static const String digitMonth = 'dd.MM.yyyy';

  static String getFormattedString({
    required DateTime date,
    required String datePattern,
    required String countryCode,
  }) {
    return DateFormat(datePattern, countryCode).format(date);
  }

  static DateTime getDateFromString({required String date}) {
    return DateTime.parse(date);
  }
}

import 'package:intl/intl.dart';

String convertDateToString(DateTime date) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
}

String changeFormatDate(String date) {
  try {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  } catch (e) {
    return 'Time error';
  }
}

import 'package:intl/intl.dart';

String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}
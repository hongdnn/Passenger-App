import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  bool isSameDate(DateTime a) =>
      (a.year == year) && (a.month == month) && (a.day == day);

  bool isYesterday(DateTime a) =>
      (difference(a).inHours > 0 && difference(a).inHours <= 24) ||
      (difference(a).inHours >= -24 && difference(a).inHours < 0);

  bool isSendAtSameMinute(DateTime a) =>
      difference(a).inMinutes < 5 && difference(a).inMinutes > -5;

  String formatDateTime() => DateFormat('MMM d, yyyy').format(this);

  String formatMonthAndYear() => DateFormat('MMM, yyyy').format(this);
}

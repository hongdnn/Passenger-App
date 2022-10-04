import 'package:intl/intl.dart';
import 'package:passenger/core/extension/datetime_extensions.dart';

extension DateUtil on int {
  String toTimeInDay() {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    return DateFormat('h:mm a').format(date);
  }

  String toReadableDayTime() {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    final DateTime now = DateTime.now();
    if (date.isSameDate(now)) return DateFormat('h:mm a').format(date);
    if (date.isYesterday(now)) return 'Yesterday';
    // return DateFormat('EE, MMM d, yyyy').format(date);
    return DateFormat('MMM d, yyyy').format(date);
  }

  String toReadableDateWeekTime() {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    final DateTime now = DateTime.now();
    if (date.isSameDate(now)) return 'Today';
    // if (date.isYesterday(now)) return 'Yesterday';
    return DateFormat('EE, MMM d, yyyy').format(date);
  }

  String toReadableSentTime() {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    final DateTime now = DateTime.now();
    if (date.isSameDate(now)) return 'Today';
    final DateFormat formatter = DateFormat('EE, MMM d, yyyy h:mm a');
    return formatter.format(date);
  }
}

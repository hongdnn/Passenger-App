import 'package:intl/intl.dart';
import 'package:passenger/core/app_config/constant.dart';

class DateUtil {
  int dayOfWeek = 0;

  static int yearLength(int year) {
    int yearLength = 0;
    for (int counter = 1; counter < year; counter++) {
      if (counter >= 4) {
        if (leapYear(counter) == true) {
          yearLength += 366;
        } else {
          yearLength += 365;
        }
      } else {
        yearLength += 365;
      }
    }
    return yearLength;
  }

  static int getNextMonth(int currentMonth) {
    if (currentMonth == 12) {
      return 1;
    }
    return ++currentMonth;
  }

  static int daysInMonth(final int monthNum, final int year) {
    if (monthNum > 12) {
      return 0;
    }
    List<int> monthLength = List<int>.filled(12, 0);
    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[4] = 31;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[9] = 31;
    monthLength[11] = 31;
    monthLength[3] = 30;
    monthLength[8] = 30;
    monthLength[5] = 30;
    monthLength[10] = 30;

    if (leapYear(year) == true) {
      monthLength[1] = 29;
    } else {
      monthLength[1] = 28;
    }

    return monthLength[monthNum - 1];
  }

  static int daysPastInYear(
    final int monthNum,
    final int dayNum,
    final int year,
  ) {
    int totalMonthLength = 0;
    for (int count = 1; count < monthNum; count++) {
      totalMonthLength += daysInMonth(count, year);
    }
    return totalMonthLength + dayNum;
  }

  static int totalLengthOfDays(
    final int monthNum,
    final int dayNum,
    final int year,
  ) =>
      daysPastInYear(monthNum, dayNum, year) + yearLength(year);

  int getWeek(int monthNum, int dayNum, int year) {
    double a = (daysPastInYear(monthNum, dayNum, year) / 7) + 1;
    return a.toInt();
  }

  static bool leapYear(int year) {
    bool leapYear = false;
    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }

  static String formatDateTimeForBooking(String locale, DateTime dateTime) {
    if (locale == 'th') {
      final String dateInTh =
          DateFormat.d(locale).add_MMM().add_y().add_Hm().format(
                dateTime.add(const Duration(days: numberOfDaysAfter543Years)),
              );
      final List<String> dateSplit = dateInTh.split(' ');
      return dateInTh.replaceAll(dateSplit.last, '');
    } else {
      return DateFormat.d(locale).add_MMM().add_y().add_Hm().format(dateTime);
    }
  }
}

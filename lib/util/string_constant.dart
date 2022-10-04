import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/features/promotion/data/model/promotion_model.dart';
import 'package:passenger/util/assets.dart';

class StringConstant {
  static const String everydayRide = 'Everyday Ride';
  static const String extraSpaceRide = 'Extra Space Ride';
  static const String orderHistoryOption = 'orderHistoryOption';

  static const Map<int, String> iconDestination = <int, String>{
    1: SvgAssets.icFirstDestination,
    2: SvgAssets.icSecondDestination,
    3: SvgAssets.icFinalDestination,
  };
  static const String mockNullString = '--/--';
  static const String mockDateTimeString = '2022-09-08T17:00:00.000Z';

  static const String reportIssueLink = 'http://www.robinhood.co.th/';
  static const String loadInfoPaymentFailed =
      'Failed to load payment information';
  static const String loadTipInvoiceFailed = 'Failed to create tip invoice';
  static const List<String> markerUrlImages = <String>[
    'https://storage.googleapis.com/ride-hailing-dev/1661309898212-Group%201.png?GoogleAccessId=ridehailing-dev-gcs%40rbh-ridehailing-dev.iam.gserviceaccount.com&Expires=10000000000&Signature=xocUYHyQphXmv8G%2BcgeBStbTxLfm4LpF7eWNwv7rLnIaFb4Kk2%2BKkGYjIMgKaMkPTsHmQNabHG1YR89R6s4DDtXRc1KomjS20gh%2Blk9KUiUTEai0qAXZY7Z5y%2FtxO3xPIZVxg6%2FIjeYqhPNNsl5oxz1TZkMkpKVoPy9R2FBT1tQBd%2Bv%2B03UuJtnH6IACuKFeW1ytdHCt9dkjjoKcn2WeRqm4Ucye43RidJIaPpat4Eay%2BvJtsFqZkDnBkwWGRI0J2A1343LWMyS%2BBhhbWgUEiGhU3747viAjMc5UWa8WklRheohtb931%2Bs9PcVkgDX4byP7uHKlwj8os4f7JmaNPeg%3D%3D',
    'https://storage.googleapis.com/ride-hailing-dev/1661311848503-des1.png?GoogleAccessId=ridehailing-dev-gcs%40rbh-ridehailing-dev.iam.gserviceaccount.com&Expires=10000000000&Signature=kxgSSJ4nPjtoGU8WQBFA1CvUQH8e90DfBstWcwy7js%2F7P75nfK7n0ND7GM1R%2FQTqyZAn9o0BnPU8Jm1b59%2FNzcjhsCQZUUCRLkgkAsFO7mbJ%2Bc5e1hF4DoFajEmJhg7lZ78DUKEHcP4KPHNql5O32lOSjUWXJuVOqZUcanS1C7wf9o0yrw7P0gfHhrCGe4zz3mjHAuhVJGStD%2BLeyodSQWOg8x5sCC%2BnoPqkGbglwjHZqAEPeuXen0a0XCpL3SBHvz9Kj4hF5kOWGZ%2FOpXgJpu1tteXrYXL5LBduslTfwET84ligWkVicNyfSTHxLM20MUVKnwf9aAbZMtO2z5V%2BZQ%3D%3D',
    'https://storage.googleapis.com/ride-hailing-dev/1661311863575-des2.png?GoogleAccessId=ridehailing-dev-gcs%40rbh-ridehailing-dev.iam.gserviceaccount.com&Expires=10000000000&Signature=VgChHTyZX8lQIzm%2FhPkO86S6P%2Bs4GUPtDp%2FvBCv8%2FfeqoajMJkf%2Fmf3GuFS%2BiVJUxYj1k1FBLWcOOhoZwDPJY0zIUKi8H%2BZDhO3Q3u4Ai%2B61NqWMwGJICEFIq%2BHNLxYRta6u40XgmVrW0xSYRY6DzAq05JTUjKRAnlVStcheMEIvOW7LEAr1QSLVHPkebUyxxBbkjcqL79ZqOTLAQ65ouLYYtDD8ORiwiZZT1n4Rv28dL61%2FVkWw6X4xCCetIFZRWl5ApMI6xHypoVNBjOKnLuLSpKiMsPLvJ9wGW1yxQR1q71SY5Vmv%2B%2BJY9jSBxv6hjl2w20fYXfcXkPjV0yXvHg%3D%3D',
    'https://storage.googleapis.com/ride-hailing-dev/1661311880573-des3.png?GoogleAccessId=ridehailing-dev-gcs%40rbh-ridehailing-dev.iam.gserviceaccount.com&Expires=10000000000&Signature=gimNjhkEtCLUl%2FLSnRH9XEdpYV3MYKmSSCVa3vQKMGkJPI8n7NWu84HcqPFp01uJU14vmwH0%2FDxJodNr0L4IkoNCnNxdBWrYU5K9CHiyRDhqmaKuVa4rPTtDPxvhCuGg1d3n4eWS9Zk46n0nG3B7LoVZJEY3jwYp1hc9T3sgyJSWqDKrWDwBqJlD84Yf%2FUG%2FprmgNL5Ttf07eABx05EU2ktIF8Za0ntvZKEnk%2FHnSmR7UCbLsL1jf7Onp06ciHfPpoIP3LVOfpw0qO83ES1O5pAjVTs3GhTo8A%2FxzLEQKgKV3SRFkV3zG8avLVNMPIL%2FAruoWELOyhC8DRD9b6byPQ%3D%3D',
  ];
  static const String markerUrlForOneDes =
      'https://storage.googleapis.com/ride-hailing-dev/1661309874305-Pin.png?GoogleAccessId=ridehailing-dev-gcs%40rbh-ridehailing-dev.iam.gserviceaccount.com&Expires=10000000000&Signature=ZmuQ21DDnZHT26tLv0VmdCH6PhtyI6baMP0PsbezmYFbcdekGJUxZWnUgtXRFAPF4CluUbp0Aw%2FF2q1FIMSwAiJpunatm0iZlJVmdxqbhw5FbrtIvXhJ5CJSnc9s6id4kvmax0E7pJ7jQsN9RtPWaEG%2FYrgk3iL23bEXi8KFmhlrNSJ9NPgEMq1WP1GPIhgy8u1TjM6HwgciSFzFhPPU4miOGhawoXoPq75x9YyWZP6rh7NjxiaooN6AKyuAoxT8OU3tN8GoOtidckDfLRyCpXRkhPSEYZaQo3%2BiPQ8WWs3lutEuBNxDgFhEX2oYaq6kI4yfMazpn8a0ixM5E0rvlQ%3D%3D';
  static const List<String> carTypeIds = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7'
  ];

  static const String xApiKey = 'd2e621a6646a4211768cd68e26f21228a81';

  static const String loadDraftTripFailed = 'Drafting trip is not available';
}

String buildDateInLocale({
  required String inputString,
  required BuildContext context,
}) {
  DateTime parseDate = DateTime.parse(inputString).toLocal();
  late String outputDate = '';
  final String defaultLocale = Localizations.localeOf(context).toString();
  if (defaultLocale == 'th') {
    final DateFormat formatter = DateFormat.yMMMd(defaultLocale);
    outputDate = formatter
        .formatInBuddhistCalendarThai(DateTime.parse(parseDate.toString()));
    return outputDate;
  } else {
    final DateFormat monthAndYear = DateFormat.yMMMM(defaultLocale);
    final DateFormat day = DateFormat.d(defaultLocale);
    outputDate =
        '''${day.format(DateTime.parse(parseDate.toString()))} ${monthAndYear.format(DateTime.parse(parseDate.toString()))}''';
  }
  return outputDate;
}

String removeDecimalZeroFormat(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}

String formatDateThailand(String inputString) {
  DateTime parseDate =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(inputString);
  final DateFormat formatter = DateFormat.MMMEd('th_TH');
  return formatter.format(DateTime.parse(parseDate.toString()));
}

String formatTimeThailand(String inputString) {
  DateTime parseDate =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(inputString);
  final DateFormat formatter = DateFormat.Hm('th_TH');
  return formatter.format(DateTime.parse(parseDate.toString()));
}

String buildDateInThaiFromDate(DateTime date) {
  final DateFormat formatter = DateFormat.yMMMd('th_TH');
  final String outputDate =
      formatter.formatInBuddhistCalendarThai(DateTime.parse(date.toString()));
  return outputDate;
}

String formatPrice(double? price) {
  if (price == null) {
    return '';
  }
  return regexForDoubleNumberWithDot.hasMatch(
    price.toString(),
  )
      ? '${price}0'
      : price.toString().replaceAll(regexForDoubleNumberWithoutDot, '');
}

extension Ex on double {
  double toPrecision() => double.parse(toStringAsFixed(doublePrecision));
}

String getTotalPrice({
  PromotionData? promotionData,
  required double discountPromo,
  required double originalPrice,
  required bool valueSelectPromotionItem,
}) {
  double priceAfterDiscount = 0;
  if (promotionData != null && valueSelectPromotionItem == true) {
    priceAfterDiscount = (originalPrice - discountPromo);
  } else {
    priceAfterDiscount = originalPrice;
  }
  return priceAfterDiscount.toString();
}

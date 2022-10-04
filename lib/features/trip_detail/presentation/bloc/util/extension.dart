import 'package:passenger/util/string_constant.dart';

extension StringExtension on String? {
  String? fitTextToScreen() {
    if (this == null) {
      return this;
    }
    if (this!.length >= 20) {
      return '${this!.substring(0, 10)}...';
    }
    return this;
  }

  bool checkValidDisplay() {
    return this?.isNotEmpty ?? false;
  }

  String validValue() {
    if (checkValidDisplay() == true) {
      return this!;
    }
    return StringConstant.mockNullString;
  }

  String? trimValue() {
    return this?.isEmpty != false ? this : this!.trim();
  }
}

extension NumExtension on num? {
  String validValue() {
    if (this == null) {
      return StringConstant.mockNullString;
    }
    return toString();
  }
}

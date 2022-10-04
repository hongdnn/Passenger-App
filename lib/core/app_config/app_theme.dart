import 'package:flutter/material.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/styles.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: StylesConstant.ts16wBold.copyWith(fontFamily: 'Kanit'),
      color: Colors.white,
      iconTheme: const IconThemeData(
        color: ColorsConstant.cBlack,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: ColorsConstant.cFFCF1E9E,
      onPrimary: ColorsConstant.cBlack,
    ),
    iconTheme: const IconThemeData(
      color: ColorsConstant.cFF73768C,
    ),
    textTheme: _lightTextTheme,
    dividerTheme: const DividerThemeData(
      color: Colors.black12,
    ),
    fontFamily: 'Kanit',
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsConstant.cBlack,
    appBarTheme: const AppBarTheme(
      color: ColorsConstant.cBlack,
      iconTheme: IconThemeData(color: ColorsConstant.cWhite),
    ),
    colorScheme: const ColorScheme.dark(
      secondary: ColorsConstant.cWhite,
      onPrimary: ColorsConstant.cWhite,
      background: Colors.white12,
    ),
    iconTheme: const IconThemeData(
      color: ColorsConstant.cFF73768C,
    ),
    textTheme: _darkTextTheme,
    dividerTheme: const DividerThemeData(color: Colors.black),
    fontFamily: 'Kanit',
  );

  static final TextTheme _lightTextTheme = TextTheme(
    headline1: StylesConstant.ts24wBold.copyWith(color: ColorsConstant.cBlack),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: StylesConstant.ts24wBold.copyWith(color: ColorsConstant.cWhite),
  );
}

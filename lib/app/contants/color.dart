import 'package:flutter/material.dart';

const appGreen = Colors.green;
const appGreenDark = Color.fromARGB(255, 14, 109, 17);
const appGreenLight1 = Color(0xFF32CD32);
const appGreenLight2 = Color.fromARGB(255, 81, 179, 81);

const appWhite = Color(0xFFFAF8FC);

ThemeData themeLight = ThemeData(
    brightness: Brightness.light,
    primaryColor: appGreen,
    scaffoldBackgroundColor: appWhite,
    appBarTheme: AppBarTheme(
      elevation: 4,
      backgroundColor: appGreen,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: appGreen),
        bodyText2: TextStyle(color: appGreen)));

ThemeData themeDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: appGreenLight2,
    scaffoldBackgroundColor: appGreenDark,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: appGreenDark,
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: appWhite),
        bodyText2: TextStyle(color: appWhite)));

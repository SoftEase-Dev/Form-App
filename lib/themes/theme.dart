import 'package:flutter/material.dart';

Color white = const Color(0xFFFFFFFF);
Color black = const Color(0xFF000000);

Color neutral_25 = const Color(0xFFFCFCFD);
Color neutral_50 = const Color(0xFFF8FAFC);
Color neutral_100 = const Color(0xFFEEF2F6);
Color neutral_200 = const Color(0xFFE3E8EF);
Color neutral_300 = const Color(0xFFCDD5DF);
Color neutral_400 = const Color(0xFF9AA4B2);
Color neutral_500 = const Color(0xFF697586);
Color neutral_600 = const Color(0xFF4B5565);
Color neutral_700 = const Color(0xFF364152);
Color neutral_800 = const Color(0xFF202939);
Color neutral_900 = const Color(0xFF121926);

Color primary_25 = const Color(0xFFFCF8E6);
Color primary_50 = const Color(0xFFF9F1CE);
Color primary_200 = const Color(0xFFF6EAB5);
Color primary_100 = const Color(0xFFF3E39C);
Color primary_300 = const Color(0xFFEED46B);
Color primary_400 = const Color(0xFFE8C639);
Color primary_500 = const Color(0xFFEFC14A);
Color primary_600 = const Color(0xFFB59306);
Color primary_700 = const Color(0xFF886E05);
Color primary_800 = const Color(0xFF5A4A03);
Color primary_900 = const Color(0xFF443702);

ThemeData lightTheme = ThemeData(
  fontFamily: 'Satoshi',
  brightness: Brightness.light,
  textTheme: TextTheme(
    displayLarge:
        TextStyle(fontSize: 72, fontWeight: FontWeight.w300, color: black),
    displayMedium:
        TextStyle(fontSize: 60, fontWeight: FontWeight.w300, color: black),
    displaySmall:
        TextStyle(fontSize: 48, fontWeight: FontWeight.w300, color: black),
    headlineMedium:
        TextStyle(fontSize: 36, fontWeight: FontWeight.w300, color: black),
    headlineSmall:
        TextStyle(fontSize: 30, fontWeight: FontWeight.w300, color: black),
    titleLarge:
        TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: black),
    bodyLarge:
        TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: black),
    bodyMedium:
        TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: black),
    bodySmall:
        TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: black),
    labelLarge:
        TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: black),
    labelMedium:
        TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primary_600),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    ),
  ),
);

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color get White => Get.isDarkMode ? Colors.white : Colors.black;

Color get Black => Get.isDarkMode ? Colors.black : Colors.white;

Color get TextColor =>
    Get.isDarkMode ? const Color(0XFF828282) : const Color(0XFF333333);

Color get outputBorder =>
    Get.isDarkMode ? const Color(0XFF252A32) : const Color(0XFFE0E0E0);

Color get inputBorder =>
    Get.isDarkMode ? const Color(0XFFFB7181) : const Color(0XFFBDBDBD);

Color get radius => const Color(0XFFD17842);

Color get border =>
    Get.isDarkMode ? const Color(0xFF21262E) : const Color(0xFFCCCCCC);

Color get search =>
    Get.isDarkMode ? const Color(0xFF141921) : const Color(0xFFF5F5F5);

Color get card =>
    Get.isDarkMode ? const Color(0x00000000) : const Color(0xFFFFFFFF);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.orange,
    secondary: Colors.orange,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderSide: BorderSide(color: inputBorder)),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0B0F14),
  primaryColor: const Color(0xFF0B0F14),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0B0F14),
    foregroundColor: Colors.white,
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.orange,
    secondary: Colors.orange,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderSide: BorderSide(color: inputBorder)),
  ),
);

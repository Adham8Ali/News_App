import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  primaryColor: const Color(0xff1E88E5),

  scaffoldBackgroundColor: Colors.white,

  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff1E88E5),
    brightness: Brightness.light,
  ),

  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),

  cardColor: Colors.white,

  iconTheme: const IconThemeData(
    color: Colors.black,
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      color: Colors.black54,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff1E88E5),
      foregroundColor: Colors.white,
    ),
  ),

  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xff1E88E5),
  ),
);
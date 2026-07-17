import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  primaryColor: const Color(0xff1E88E5),

  scaffoldBackgroundColor: const Color(0xff121212),

  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff1E88E5),
    brightness: Brightness.dark,
  ),

  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff121212),
    foregroundColor: Colors.white,
  ),

  cardColor: const Color(0xff1E1E1E),

  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      color: Colors.white70,
    ),
    bodyMedium: TextStyle(
      color: Colors.white60,
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
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        color: Colors.cyan, iconTheme: IconThemeData(color: Colors.black)),
    colorScheme: const ColorScheme.light(
      primary: Colors.grey,
      onPrimary: Colors.black,
      secondary: Colors.blue,
      primaryContainer: Colors.cyan,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
        color: Color(0xFF353131),
        iconTheme: IconThemeData(color: Colors.white)),
    colorScheme: const ColorScheme.dark(
      primary: Colors.grey,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF353131),
    ),
  );
}

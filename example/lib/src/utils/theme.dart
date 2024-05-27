import "package:flutter/material.dart";

ThemeData getTheme() => ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(250, 249, 246, 1),
      textTheme: const TextTheme(
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(0, 0, 0, 1),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(60, 60, 59, 1),
          fontWeight: FontWeight.w700,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      colorScheme: const ColorScheme.light(
        primary: Color.fromRGBO(64, 87, 122, 1),
        secondary: Color.fromRGBO(255, 255, 255, 1),
        surface: Color.fromRGBO(250, 249, 246, 1),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(64, 87, 122, 1),
        titleTextStyle: TextStyle(
          fontSize: 28,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );

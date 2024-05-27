import "package:flutter/material.dart";

ThemeData getTheme() => ThemeData(
      scaffoldBackgroundColor: const Color.fromRGBO(250, 249, 246, 1),
      textTheme: const TextTheme(
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(60, 60, 59, 1),
          fontWeight: FontWeight.w700,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
      ),
      colorScheme: const ColorScheme.light(
        primary: Color.fromRGBO(64, 87, 122, 1),
        secondary: Colors.white,
        surface: Color.fromRGBO(250, 249, 246, 1),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(64, 87, 122, 1),
        titleTextStyle: TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
      ),
    );

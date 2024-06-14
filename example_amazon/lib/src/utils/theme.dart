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
        primary: Color.fromRGBO(161, 203, 211, 1),
        secondary: Color.fromRGBO(221, 235, 238, 1),
        surface: Color.fromRGBO(255, 255, 255, 1),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromRGBO(161, 220, 218, 1),
        foregroundColor: Colors.black,
        titleTextStyle: TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Colors.yellow,
          ),
          foregroundColor: WidgetStateProperty.all(
            Colors.black,
          ),
        ),
      ),
    );

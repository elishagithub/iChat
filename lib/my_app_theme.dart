import 'package:flutter/material.dart';

class MyAppTheme {
  static final themeData = ThemeData(
    brightness: Brightness.light,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xFF3a7668),
      secondary: const Color(0xFF89B49F),
    ),
    dialogBackgroundColor: Colors.white,
    disabledColor: Colors.grey,
    dividerColor: Colors.grey[300]!,
    focusColor: Colors.green,
    highlightColor: Colors.transparent,
    hintColor: Colors.grey,
    appBarTheme: const AppBarTheme(color: Color(0xFF3a7668)),
    hoverColor: Colors.green,
    indicatorColor: const Color.fromARGB(255, 89, 180, 159),
    primaryColor: const Color(0xFF3a7668),
    primaryColorDark: const Color.fromARGB(255, 35, 71, 63),
    primaryColorLight: const Color.fromARGB(255, 89, 180, 159),
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.grey[200]!,
    secondaryHeaderColor: Colors.grey[200]!,
    shadowColor: Colors.grey[500]!,
    splashColor: Colors.green,
    unselectedWidgetColor: Colors.grey,
    fontFamily: 'Montserrat',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
      displayMedium: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.25,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.1,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.25,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.1,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.1,
      ),
    ),
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      fillColor: Colors.grey[200],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.0),
        borderSide: const BorderSide(color: Color(0xFF3a7668)),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFF3a7668)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(3.0),
      ),
    ),
  );
}

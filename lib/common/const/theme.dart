import 'package:flutter/material.dart';

final darkTheme = lightTheme.copyWith(
  iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
  cardTheme: CardTheme(color: Colors.white.withOpacity(0.65)),
);

final lightTheme = ThemeData(
  hintColor: Colors.black87,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(),
  iconTheme: IconThemeData(color: Colors.black, opacity: 0.8),
  cardTheme: CardTheme(color: Colors.white.withOpacity(0.55)),
  errorColor: Colors.black,
  textTheme: TextTheme(
    button: TextStyle(
      color: Colors.black,
    ),
    headline1: TextStyle(
      color: Colors.black,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      color: Colors.black,
    ),
  ),
);

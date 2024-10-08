import 'package:flutter/material.dart';

var lightThemeData = ThemeData(
  primarySwatch: Colors.blueGrey,
  backgroundColor: Colors.white,
  cardColor: Colors.blueGrey.shade50,
  primaryTextTheme: TextTheme(
    button: TextStyle(
      color: Colors.blueGrey,
      decorationColor: Colors.blueGrey.shade300,
    ),
    subtitle2: TextStyle(
      color: Colors.blueGrey.shade900,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
    ),
    headline1: TextStyle(color: Colors.blueGrey.shade800),
    headline2: TextStyle(
        fontSize: 24,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent),
  ),
  bottomAppBarColor: Colors.blueGrey.shade900,
  iconTheme: IconThemeData(color: Colors.blueGrey),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white70)),
);

var darkThemeData = ThemeData(
  primarySwatch: Colors.blueGrey,
  backgroundColor: Colors.blueGrey.shade900,
  cardColor: Colors.black,
  primaryTextTheme: TextTheme(
    button: TextStyle(
      color: Colors.blueGrey.shade200,
      decorationColor: Colors.blueGrey.shade50,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      color: Colors.blueGrey.shade300,
    ),
    headline1: TextStyle(
      color: Colors.white70,
    ),
    headline2: TextStyle(
      fontSize: 24,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomAppBarColor: Colors.black,
  iconTheme: IconThemeData(color: Colors.blueGrey.shade200),
  brightness: Brightness.dark,
);

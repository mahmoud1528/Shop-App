import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData getDarkMode() => ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: HexColor('#1B2529'),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 30.0),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('#1B2529'),
        statusBarIconBrightness: Brightness.light,
      ),

    ),
    scaffoldBackgroundColor: HexColor('#1B2529'),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('#1B2529'),
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      headlineSmall: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      bodyMedium: TextStyle(
        color: Colors.grey,
        fontFamily: 'Jannah',
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.deepOrange
)
);

ThemeData getLightMode() => ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      actionsIconTheme: IconThemeData(color: Colors.black, size: 30.0),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Jannah',
      ),
      bodyMedium: TextStyle(
        color: Colors.grey,
        fontFamily: 'Jannah',
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.blue,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.blue
    )
);

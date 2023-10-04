import 'package:flutter/material.dart';

class CustomeThemes {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
      ),
      centerTitle: false,
      backgroundColor: Colors.red,
      toolbarHeight: 55.5,
      shadowColor: Colors.indigo,
      actionsIconTheme: IconThemeData(
        size: 20.0,
        color: Colors.white,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      shadowColor: Colors.red,
      elevation: 1.0,
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
  );
}

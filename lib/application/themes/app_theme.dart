import 'package:flutter/material.dart';

import '../../presentation/managers/colors.dart';
import '../../presentation/managers/values.dart';

ThemeData getAppTheme() {
  return ThemeData(
    // Scaffold
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.green,

    // app bar
    appBarTheme: const AppBarTheme(
        titleSpacing: DoubleManager.value20,
        toolbarHeight: DoubleManager.value140,
        elevation: DoubleManager.value0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.black)),
    bottomAppBarColor: Colors.black,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      labelStyle: TextStyle(),
    ),

    // Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorsManager.buttonColor,
        textStyle: const TextStyle(
            fontSize: DoubleManager.value15, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DoubleManager.value12)),
      ),
    ),

    // text form field
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey[50],
      filled: true,
      contentPadding: const EdgeInsets.all(DoubleManager.value20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DoubleManager.value15),
          borderSide: const BorderSide(width: 0, color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 0),
        borderRadius: BorderRadius.circular(DoubleManager.value15),
      ),
    ),

    // Card
    cardTheme: CardTheme(
      margin: const EdgeInsets.symmetric(
          horizontal: DoubleManager.value4, vertical: DoubleManager.value10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DoubleManager.value20),
      ),
    ),
  );
}

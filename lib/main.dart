import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

//seedcolr is a constructive function that will automatically create a color scheme with different
//shades of colors based on one color
var kcolorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
//dark theme
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,

         cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
         ),
          elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kcolorScheme.onPrimaryContainer,
          foregroundColor: kcolorScheme.primaryContainer,
        ), //card widget is used for our expense item
        cardTheme: const CardTheme().copyWith(
          color: kcolorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kcolorScheme.primaryContainer,
          ),
        ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              //title in app
              fontWeight: FontWeight.bold,
              color: kcolorScheme.onSecondaryContainer,
              fontSize: 16,
            ),
          ),
      ),
      //which theme will be used
      themeMode: ThemeMode.system, //default
      home: const Expenses(),
      //copywith() = you can get some default app bar theme settings by flutter
    ),
  );
}
//Material 3 is used to control in detail which color, different widgets in your app will have &
//which color you want to be able to use in your app and text style to be use and so on.

import 'package:ecommerce_app/constants/app_pallete.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AppTheme {
  //here we pass the default value of the color inside the big braces
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: GlobalVariables.backgroundColor,
    appBarTheme:
        const AppBarTheme(backgroundColor: GlobalVariables.greyBackgroundCOlor),
    inputDecorationTheme: InputDecorationTheme(
      // contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );

  static final darkthemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      appBarTheme: const AppBarTheme(backgroundColor: AppPallete.greyColor),
      inputDecorationTheme: InputDecorationTheme(
        // contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border(),
        focusedBorder: _border(AppPallete.gradient2),
      ));
}

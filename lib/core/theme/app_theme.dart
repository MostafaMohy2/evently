import 'package:evently/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppColors appColors;

  AppTheme(this.appColors);

  ThemeData get theme => ThemeData(
    colorScheme: ColorScheme(
      brightness: appColors.brightness,
      primary: appColors.mainColor,
      onPrimary: appColors.inputColor,
      secondary: appColors.mainTextColor,
      onSecondary: appColors.inputColor,
      error: appColors.errorColor,
      onError: appColors.inputColor,
      surface: appColors.backgroundColor,
      onSurface: appColors.mainColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: appColors.backgroundColor,
      foregroundColor: appColors.mainTextColor,
    ),
    scaffoldBackgroundColor: appColors.backgroundColor,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        minimumSize: Size(double.infinity, 56),
        textStyle: TextStyle(fontSize: 20, fontWeight: .bold),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(color: appColors.mainTextColor),
      displayMedium: TextStyle(color: appColors.mainTextColor),
      displaySmall: TextStyle(color: appColors.mainTextColor),
      headlineLarge: TextStyle(color: appColors.mainTextColor),
      headlineMedium: TextStyle(color: appColors.mainTextColor),
      headlineSmall: TextStyle(color: appColors.mainTextColor),
      titleLarge: TextStyle(color: appColors.mainTextColor),
      titleMedium: TextStyle(color: appColors.mainTextColor),
      titleSmall: TextStyle(color: appColors.mainTextColor),
      bodyLarge: TextStyle(color: appColors.mainTextColor),
      bodyMedium: TextStyle(color: appColors.mainTextColor),
      bodySmall: TextStyle(color: appColors.mainTextColor),
      labelLarge: TextStyle(color: appColors.mainTextColor),
      labelMedium: TextStyle(color: appColors.mainTextColor),
      labelSmall: TextStyle(color: appColors.mainTextColor),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: appColors.mainColor,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
    ),
  );
}

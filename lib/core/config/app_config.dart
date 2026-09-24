import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppConfig {
  static ThemeData get lightAppTheme => AppTheme(LightAppColors()).theme;
  static ThemeData get darkAppTheme => AppTheme(DarkAppColors()).theme;

  static ThemeMode thememode = ThemeMode.light;

  static void toggleTheme(){
    thememode = thememode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig extends ChangeNotifier {
  ThemeData get lightAppTheme => AppTheme(LightAppColors()).theme;
  ThemeData get darkAppTheme => AppTheme(DarkAppColors()).theme;

  ThemeMode thememode;

  String locale;

  AppConfig(this.locale, this.thememode);

  Future<void> changeTheme(ThemeMode theme) async {
    thememode = theme;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('theme', thememode == ThemeMode.light);
  }

  Future<void> changeLocale(String lang) async {
    locale = lang;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('locale', lang);
  }
}

import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppConfig extends ChangeNotifier {
  ThemeData get lightAppTheme => AppTheme(LightAppColors()).theme;
  ThemeData get darkAppTheme => AppTheme(DarkAppColors()).theme;

  ThemeMode thememode = ThemeMode.light;

  String locale = 'en';

  void changeTheme(ThemeMode theme) {
    thememode = theme;
    notifyListeners();
  }

  void changeLocale(String lang){
    locale = lang;
    notifyListeners();
  }
}

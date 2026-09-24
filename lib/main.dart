import 'package:evently/core/config/app_config.dart';
import 'package:evently/screens/setup/setup_screen.dart';
import 'package:evently/screens/splahs/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppConfig.lightAppTheme,
      darkTheme: AppConfig.darkAppTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.route : (_) => SplashScreen(),
        SetupScreen.route : (_) => SetupScreen(),
      },
      initialRoute: SplashScreen.route,
    );
  }
}
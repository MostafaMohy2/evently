import 'package:evently/core/config/app_config.dart';
import 'package:evently/screens/setup/setup_screen.dart';
import 'package:evently/screens/splahs/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/l10n/app_localizations.dart';
import 'firebase_options.dart';
import 'screens/auth/forget_password/forget_password_screen.dart';
import 'screens/auth/login/login_screen.dart';
import 'screens/auth/signup/signup_screen.dart';
import 'screens/onboarding/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var theme = sharedPreferences.getBool('theme') ?? true
      ? ThemeMode.light
      : ThemeMode.dark;
  var local = sharedPreferences.getString('local') ?? 'en';
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppConfig(local, theme),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppConfig>(
      builder: (context, provider, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: provider.lightAppTheme,
        darkTheme: provider.darkAppTheme,
        themeMode: provider.thememode,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        locale: Locale(provider.locale),
        supportedLocales: AppLocalizations.supportedLocales,
        routes: {
          SplashScreen.route: (_) => SplashScreen(),
          SetupScreen.route: (_) => SetupScreen(),
          OnBoardingScreen.route: (_) => OnBoardingScreen(),
          LoginScreen.route: (_) => LoginScreen(),
          SignupScreen.route: (_) => SignupScreen(),
          ForgetPasswordScreen.route: (_) => ForgetPasswordScreen(),
        },
        initialRoute: SplashScreen.route,
      ),
    );
  }
}

import 'package:evently/core/config/app_config.dart';
import 'package:evently/screens/setup/setup_screen.dart';
import 'package:evently/screens/splahs/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppConfig(),
      child: Consumer<AppConfig>(
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
          },
          initialRoute: SplashScreen.route,
        ),
      ),
    );
  }
}

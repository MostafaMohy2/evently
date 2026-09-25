import 'package:evently/core/config/app_config.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/screens/setup/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, SetupScreen.route);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  provider.thememode == ThemeMode.light
                      ? AppAssets.logoLight
                      : AppAssets.logoDark,
                ),
              ),
            ),
            Image.asset(
              provider.thememode == ThemeMode.light
                  ? AppAssets.brandingLight
                  : AppAssets.brandingDark,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}

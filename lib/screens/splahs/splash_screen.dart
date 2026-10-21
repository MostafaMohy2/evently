import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:evently/screens/setup/setup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      if (!mounted) return;
      User? user = FirebaseAuth.instance.currentUser;
      context.pushReplacementNamed(
        user == null ? SetupScreen.route : HomeScreen.route,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.appConfig;
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
              width: context.screenWidth * 0.5,
            ),
          ],
        ),
      ),
    );
  }
}

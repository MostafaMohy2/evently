import 'package:evently/core/config/app_config.dart';
import 'package:evently/core/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/app_assets.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String route = '/forget-password';
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Forget Passowrd',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .start,
          spacing: 40,
          children: [
            SizedBox(height: 50),
            Image.asset(
              provider.thememode == ThemeMode.light
                  ? AppAssets.forgetPassowrdLight
                  : AppAssets.forgetPassowrdDark,
            ),
            FilledButton(
              onPressed: () async {
                User? user = FirebaseAuth.instance.currentUser;
                await FirebaseAuth.instance.setLanguageCode(
                  provider.locale == 'en' ? 'en' : 'ar',
                );
                await user?.sendEmailVerification();
                Navigator.pop(context);
              },
              child: Text(
                locale.resetPassword,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

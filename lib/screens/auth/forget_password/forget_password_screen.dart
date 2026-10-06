import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String route = '/forget-password';
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.appConfig;
    final locale = context.locale;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Forget Passowrd',
          style: context.textTheme.titleMedium,
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
                if (!context.mounted) return;
                context.pop();
              },
              child: Text(
                locale.resetPassword,
                style: context.textTheme.titleLarge!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:evently/core/config/app_config.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/widget_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var provider = Provider.of<AppConfig>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .center,
          spacing: 16,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colorScheme.onError,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(AppAssets.route)),
              ),
              width: MediaQuery.of(context).size.width * .3,
              height: MediaQuery.of(context).size.width * .3,
            ),
            Text(user?.displayName ?? context.locale.user),
            Text(user?.email ?? context.locale.email),

            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.onError,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(provider.isDark ? context.locale.darkMode : context.locale.lightMode),
                  Switch(
                    value: provider.isDark,
                    onChanged: (value) {
                      provider.changeTheme(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.onError,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(provider.isEn ? context.locale.english : context.locale.arabic),
                  Switch(
                    value: provider.isEn,
                    onChanged: (value) {
                      provider.changeLocale(value ? 'en' : 'ar');
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.onError,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(context.locale.signOut),
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: Icon(Icons.logout_outlined, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ).allPadding(16),
      ),
    );
  }
}

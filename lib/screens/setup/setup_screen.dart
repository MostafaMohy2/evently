import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/screens/onboarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_assets.dart';

class SetupScreen extends StatefulWidget {
  static const String route = '/setup';
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.appConfig;
    final locale = context.locale;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 16,
            children: [
              Center(
                child: Image.asset(
                  provider.isLight
                      ? AppAssets.logoLight
                      : AppAssets.logoDark,
                  width: context.screenWidth * .3,
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    provider.isLight
                        ? AppAssets.setupLight
                        : AppAssets.setupDark,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                locale.personalizeYourExperience,
                style: context.textTheme.titleLarge,
              ),
              Text(
                locale.setupDescription,
                style: context.textTheme.bodyLarge,
              ),
              Row(
                spacing: 8,
                children: [
                  Text(
                    locale.language,
                    style: context.textTheme.titleMedium,
                  ),
                  Spacer(),
                  _buildOptionChip(
                    Text(
                      locale.english,
                      style: context.textTheme.titleMedium!.copyWith(
                        color: _getChipColor(provider.locale == 'en'),
                      ),
                    ),
                    () {
                      provider.changeLocale('en');
                    },
                    provider.locale == 'en',
                  ),
                  _buildOptionChip(
                    Text(
                      locale.arabic,
                      style: context.textTheme.titleMedium!.copyWith(
                        color: _getChipColor(provider.locale == 'ar'),
                      ),
                    ),
                    () {
                      provider.changeLocale('ar');
                    },
                    provider.locale == 'ar',
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Text(
                    locale.theme,
                    style: context.textTheme.titleMedium,
                  ),
                  Spacer(),
                  _buildOptionChip(
                    Icon(
                      Icons.light_mode_outlined,
                      color: _getChipColor(
                        provider.isLight,
                      ),
                    ),
                    () {
                      provider.changeTheme(ThemeMode.light);
                    },
                    provider.isLight
                  ),
                  _buildOptionChip(
                    Icon(
                      Icons.dark_mode_outlined,
                      color: _getChipColor(
                        provider.isDark,
                      ),
                    ),
                    () {
                      provider.changeTheme(ThemeMode.dark);
                    },
                    provider.isDark,
                  ),
                ],
              ),
              FilledButton(
                onPressed: () {
                  context.pushReplacementNamed(
                    OnBoardingScreen.route,
                  );
                },
                child: Text(locale.letsStart, style: context.textTheme.titleLarge!.copyWith(
                  color: Colors.white
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getChipColor(bool isSelected) {
    final provider = context.appConfig;
    return provider.isLight
        ? isSelected
              ? LightAppColors().inputColor
              : LightAppColors().mainColor
        : DarkAppColors().mainTextColor;
  }

  Widget _buildOptionChip(Widget child, VoidCallback onTap, bool isSelected) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            width: 2,
            color: context.colorScheme.primary,
          ),
          color: isSelected ? context.colorScheme.primary : null,
        ),
        child: child,
      ),
    );
  }
}

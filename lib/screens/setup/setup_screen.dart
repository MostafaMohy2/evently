import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_config.dart';
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
    var provider = Provider.of<AppConfig>(context);
    final AppLocalizations locale = AppLocalizations.of(context)!;
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
                  provider.thememode == ThemeMode.light
                      ? AppAssets.logoLight
                      : AppAssets.logoDark,
                  width: MediaQuery.of(context).size.width * .3,
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    provider.thememode == ThemeMode.light
                        ? AppAssets.setupLight
                        : AppAssets.setupDark,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                locale.personalizeYourExperience,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                locale.setupDescription,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                spacing: 8,
                children: [
                  Text(
                    locale.language,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  _buildOptionChip(
                    Text(
                      locale.english,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: _getChipColor(provider.locale == 'en',),
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: _getChipColor(provider.locale == 'ar',),
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  _buildOptionChip(
                    Icon(Icons.light_mode_outlined, color: _getChipColor(provider.thememode == ThemeMode.light)),
                    () {
                      provider.changeTheme(ThemeMode.light);
                    },
                    provider.thememode == ThemeMode.light,
                  ),
                  _buildOptionChip(
                    Icon(Icons.dark_mode_outlined, color: _getChipColor(provider.thememode == ThemeMode.dark)),
                    () {
                      provider.changeTheme(ThemeMode.dark);
                    },
                    provider.thememode == ThemeMode.dark,
                  ),
                ],
              ),
              FilledButton(onPressed: () {}, child: Text(locale.letsStart)),
            ],
          ),
        ),
      ),
    );
  }

  Color _getChipColor(bool isSelected) {
    var provider = Provider.of<AppConfig>(context);
    return provider.thememode == ThemeMode.light
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
            color: Theme.of(context).colorScheme.primary,
          ),
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
        child: child,
      ),
    );
  }
}

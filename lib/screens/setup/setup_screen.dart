import 'package:evently/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
                  AppConfig.thememode == ThemeMode.light
                      ? AppAssets.logoLight
                      : AppAssets.logoDark,
                  width: MediaQuery.of(context).size.width * .5,
                ),
              ),
              Expanded(
                child: Image.asset(
                  AppConfig.thememode == ThemeMode.light
                      ? AppAssets.setupLight
                      : AppAssets.setupDark,
                ),
              ),
              Text(
                'Personalize Your Experience',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                spacing: 8,
                children: [
                  Text(
                    'Language',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  _buildOptionChip(
                    Text(
                      'English',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: _getChipColor(true),
                      ),
                    ),
                    true,
                  ),
                  _buildOptionChip(
                    Text(
                      'Arabic',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: _getChipColor(false)
                      ),
                    ),
                    false,
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Text('Theme', style: Theme.of(context).textTheme.titleMedium),
                  Spacer(),
                  _buildOptionChip(
                    Icon(
                      Icons.light_mode_outlined,
                      color: _getChipColor(true),
                    ),
                    true,
                  ),
                  _buildOptionChip(
                    Icon(
                      Icons.dark_mode_outlined,
                      color: _getChipColor(false),
                    ),
                    false,
                  ),
                ],
              ),
              FilledButton(onPressed: () {}, child: Text("Let's Start")),
            ],
          ),
        ),
      ),
    );
  }

  Color _getChipColor(bool isSelected){
    return AppConfig.thememode == ThemeMode.light ? isSelected? LightAppColors().inputColor : LightAppColors().mainColor : LightAppColors().mainTextColor;
  }

  Widget _buildOptionChip(Widget child, bool isSelected) {
    return Container(
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
    );
  }
}

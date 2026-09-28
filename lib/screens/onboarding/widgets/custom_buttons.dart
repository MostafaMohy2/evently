import 'package:evently/core/config/app_config.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.provider, required this.child});

  final AppConfig provider;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
              color: provider.thememode == ThemeMode.light
          ? LightAppColors().strokeColor
          : DarkAppColors().strokeColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.primary
          )
      ),
      child: child,
    );
  }
}

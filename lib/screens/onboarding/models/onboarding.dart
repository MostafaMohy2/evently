import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

class Onboarding {
  String imageLight;
  String imageDark;
  String title;
  String description;

  Onboarding({
    required this.imageLight,
    required this.imageDark,
    required this.title,
    required this.description,
  });

  static List<Onboarding> onboarding(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return [
      Onboarding(
        imageLight: AppAssets.onboarding1Light,
        imageDark: AppAssets.onboarding1Dark,
        title: locale.findEventsThatInspireYou,
        description: locale.findEventsThatInspireYouDescription,
      ),
      Onboarding(
        imageLight: AppAssets.onboarding2Light,
        imageDark: AppAssets.onboarding2Dark,
        title: locale.effortlessEventPlanning,
        description: locale.effortlessEventPlanningDescription,
      ),
      Onboarding(
        imageLight: AppAssets.onboarding3Light,
        imageDark: AppAssets.onboarding3Dark,
        title: locale.connectWithFriendsAndShareMoments,
        description: locale.connectWithFriendsAndShareMomentsDescription,
      ),
    ];
  }
}

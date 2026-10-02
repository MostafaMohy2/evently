import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/screens/onboarding/models/onboarding.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/config/app_config.dart';
import '../../core/utils/app_assets.dart';
import '../auth/login/login_screen.dart';
import 'widgets/custom_buttons.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String route = '/onboarding';
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController imgController = PageController();
  final PageController textController = PageController();

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfig>(context);
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final onboards = Onboarding.onboarding(context);
    int lastPageIndex = onboards.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 24,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Visibility(
                    visible: pageIndex != 0,
                    child: GestureDetector(
                      onTap: () {
                        imgController.previousPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                        textController.previousPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: CustomButton(
                        provider: provider,
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: provider.thememode == ThemeMode.light
                              ? LightAppColors().mainTextColor
                              : DarkAppColors().mainTextColor,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    provider.thememode == ThemeMode.light
                        ? AppAssets.logoLight
                        : AppAssets.logoDark,
                    width: MediaQuery.of(context).size.width * .4,
                  ),
                  Visibility(
                    visible: pageIndex != lastPageIndex,
                    child: GestureDetector(
                      onTap: () {
                        imgController.jumpToPage(lastPageIndex);
                        textController.jumpToPage(lastPageIndex);
                      },
                      child: CustomButton(
                        provider: provider,
                        child: Text(
                          locale.skip,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                flex: 2,
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: onboards.length,
                  onPageChanged: (value) {
                    pageIndex = value;
                    setState(() {});
                  },
                  controller: imgController,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      provider.thememode == ThemeMode.light
                          ? onboards[index].imageLight
                          : onboards[index].imageDark,
                    );
                  },
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  count: onboards.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 7,
                    dotHeight: 7,
                    activeDotColor: provider.thememode == ThemeMode.light
                        ? LightAppColors().mainColor
                        : DarkAppColors().mainColor,
                    dotColor: provider.thememode == ThemeMode.light
                        ? LightAppColors().disabledColor
                        : DarkAppColors().mainTextColor,
                  ),
                  controller: imgController,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: onboards.length,
                  onPageChanged: (value) {
                    pageIndex = value;
                    setState(() {});
                  },
                  controller: textController,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: .start,
                      spacing: 5,
                      children: [
                        Align(
                          alignment: .centerStart,
                          child: Text(
                            onboards[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Text(
                          onboards[index].description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    );
                  },
                ),
              ),
              FilledButton(
                onPressed: () {
                  if (pageIndex != lastPageIndex) {
                    imgController.nextPage(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                    textController.nextPage(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushReplacementNamed(context, LoginScreen.route);
                  }
                },
                child: Text(
                  pageIndex == lastPageIndex ? locale.getStarted : locale.next,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

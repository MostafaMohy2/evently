import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/screens/onboarding/models/onboarding.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    final provider = context.appConfig;
    final locale = context.locale;
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
                          color: provider.isLight
                              ? LightAppColors().mainTextColor
                              : DarkAppColors().mainTextColor,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    provider.isLight
                        ? AppAssets.logoLight
                        : AppAssets.logoDark,
                    width: context.screenWidth * .4,
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
                          style: context.textTheme.titleLarge,
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
                      provider.isLight
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
                    activeDotColor: provider.isLight
                        ? LightAppColors().mainColor
                        : DarkAppColors().mainColor,
                    dotColor: provider.isLight
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
                            style: context.textTheme.titleLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            onboards[index].description,
                            style: context.textTheme.bodyLarge,
                          ),
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
                    context.pushReplacementNamed(LoginScreen.route);
                  }
                },
                child: Text(
                  pageIndex == lastPageIndex ? locale.getStarted : locale.next,
                  style: context.textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

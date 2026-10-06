import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/icons_extensions.dart';
import 'package:evently/core/utils/number_extensions.dart';
import 'package:evently/core/utils/widget_extensions.dart';
import 'package:evently/screens/home/models/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Category> allCategories = [];

  int selectedIndex = 0;

  @override
  void initState() {
    allCategories.add(Category(Icons.border_all_rounded, 'all', 'الكل', 'All'));
    allCategories.addAll(categories);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [_buildHeader(), _buildTabBar(selectedIndex)]),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(context.locale.welocmeBack , style: context.textTheme.titleMedium),
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? "User",
              style: context.textTheme.titleLarge,
            ),
          ],
        ),
        Spacer(),
        Row(
          spacing: 8,
          children: [
            IconButton(
              onPressed: () {
                final config = context.appConfigListenFalse;
                config.changeTheme(
                  config.isLight ? ThemeMode.dark : ThemeMode.light,
                );
              },
              icon: context.appConfig.isLight
                  ? Icons.light_mode_outlined.toIcon
                  : Icons.dark_mode_outlined.toIcon,
              color: context.appConfig.isLight
                  ? LightAppColors().mainColor
                  : DarkAppColors().mainTextColor,
              style: IconButton.styleFrom(minimumSize: Size(24, 24)),
            ),
            GestureDetector(
              onTap: () {
                final config = context.appConfigListenFalse;
                config.changeLocale(config.locale == 'en' ? 'ar' : 'en');
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  context.appConfig.locale,
                  style: context.textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ).allPadding(16);
  }

  Widget _buildTabBar(int selectedIndex) {
    return DefaultTabController(
      length: allCategories.length,
      child: TabBar(
        tabAlignment: .start,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        dividerHeight: 0,
        onTap: (index) {
          setState(() {
            this.selectedIndex = index;
          });
        },
        indicatorSize: .label,
        labelPadding: EdgeInsets.symmetric(horizontal: 8),
        tabs: allCategories
            .map(
              (category) => Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.colorScheme.primary,
                    width: .6,
                  ),
                  color: selectedIndex == allCategories.indexOf(category)
                      ? context.colorScheme.primary
                      : context.colorScheme.onSecondary,
                ),
                child: Row(
                  children: [
                    Icon(
                      category.icon,
                      color: selectedIndex == allCategories.indexOf(category)
                          ? Colors.white
                          : context.colorScheme.primary,
                    ),
                    8.horizontalSpace,
                    Text(
                      context.appConfig.locale == 'en'
                          ? category.nameEn
                          : category.nameAr,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: selectedIndex == allCategories.indexOf(category)
                            ? Colors.white
                            : context.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

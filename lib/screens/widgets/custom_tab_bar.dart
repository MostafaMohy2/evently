import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/models/category.dart';
import 'package:flutter/material.dart';

import '../../core/utils/number_extensions.dart';

class CustomTabBar extends StatelessWidget {
  final List<Category> categories;

  final Function(int) selectEvent;

  final int selectedIndex;

  const CustomTabBar({
    required this.categories,
    required this.selectedIndex,
    required this.selectEvent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: TabBar(
        tabAlignment: .start,
        isScrollable: true,
        indicatorColor: Colors.transparent,
        dividerHeight: 0,
        onTap: selectEvent,
        indicatorSize: .label,
        labelPadding: EdgeInsets.symmetric(horizontal: 8),
        tabs: categories
            .map(
              (category) => Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.colorScheme.primary,
                    width: .6,
                  ),
                  color: selectedIndex == categories.indexOf(category)
                      ? context.colorScheme.primary
                      : context.colorScheme.onSecondary,
                ),
                child: Row(
                  children: [
                    Icon(
                      category.icon,
                      color: selectedIndex == categories.indexOf(category)
                          ? Colors.white
                          : context.colorScheme.primary,
                    ),
                    8.horizontalSpace,
                    Text(
                      context.appConfig.locale == 'en'
                          ? category.nameEn
                          : category.nameAr,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: selectedIndex == categories.indexOf(category)
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/models/event.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/icons_extensions.dart';
import 'package:evently/core/utils/number_extensions.dart';
import 'package:evently/core/utils/widget_extensions.dart';
import 'package:evently/core/models/category.dart';
import 'package:evently/firebase/firebase_database.dart';
import 'package:evently/screens/event_management/event_details_screen.dart';
import 'package:evently/screens/widgets/event_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_tab_bar.dart';

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
    allCategories.add(
      Category(Icons.border_all_rounded, 'all', 'الكل', 'All', '', ''),
    );
    allCategories.addAll(categoriesList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          CustomTabBar(
            categories: allCategories,
            selectedIndex: selectedIndex,
            selectEvent: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Event>>(
              stream: FirebaseDatabase().getEventsStream(
                category: selectedIndex == 0
                    ? null
                    : allCategories[selectedIndex].id,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == .waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  var event =
                      snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                  event.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
                  if (event.isEmpty) {
                    return Center(child: Text('no events found'));
                  } else {
                    return ListView.separated(
                      padding: EdgeInsets.all(16),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            EventDetailsScreen.route,
                            arguments: event[index],
                          );
                        },
                        child: EventCard(event: event[index]),
                      ),
                      separatorBuilder: (_, _) => 16.verticalSpace,
                      itemCount: event.length,
                    );
                  }
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              context.locale.welcomeBack,
              style: context.textTheme.titleMedium,
            ),
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
}

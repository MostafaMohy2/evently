import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/icons_extensions.dart';
import 'package:evently/screens/home/tabs/favorite_tab.dart';
import 'package:evently/screens/home/tabs/home_tab.dart';
import 'package:flutter/material.dart';

import '../event_management/event_management_screen.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];

    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icons.home_outlined.toIcon,
            activeIcon: Icons.home.toIcon,
            label: context.locale.home,
          ),
          BottomNavigationBarItem(
            icon: Icons.favorite_border_outlined.toIcon,
            activeIcon: Icons.favorite.toIcon,
            label: context.locale.favorite,
          ),
          BottomNavigationBarItem(
            icon: Icons.person_outline.toIcon,
            activeIcon: Icons.person.toIcon,
            label: context.locale.profile,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, EventManagementScreen.route);
        },
        child: Icons.add.toIcon,
      ),
    );
  }
}

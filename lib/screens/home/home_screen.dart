import 'package:evently/core/utils/build_context_extensions.dart';
import 'package:evently/core/utils/icons_extensions.dart';
import 'package:evently/core/utils/number_extensions.dart';
import 'package:evently/core/utils/widget_extensions.dart';
import 'package:evently/screens/home/tabs/home_tab.dart';
import 'package:flutter/material.dart';

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
    final tabs = [
      HomeTab(),
      _buildPlaceholderTab(context.colorScheme.tertiary, 'Favorites Tab'),
      _buildPlaceholderTab(context.colorScheme.secondary, 'Profile Tab'),
    ];

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
        onPressed: () {},
        child: Icons.add.toIcon,
      ),
    );
  }

  Widget _buildPlaceholderTab(Color color, String label) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: context.textTheme.headlineMedium?.copyWith(
              color: context.colorScheme.onError,
            ),
          ),
          16.verticalSpace,
          Text(
            'Coming soon...',
            style: context.textTheme.bodyLarge,
          ).allPadding(24),
        ],
      ),
    );
  }
}

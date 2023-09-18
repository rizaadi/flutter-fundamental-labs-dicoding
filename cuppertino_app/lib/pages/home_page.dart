import 'package:cuppertino_app/pages/feeds_page.dart';
import 'package:cuppertino_app/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';

import 'package:cuppertino_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      // ignore: prefer_const_literals_to_create_immutables
      tabBar: CupertinoTabBar(items: [
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.news),
          label: 'Feeds',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'Search',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.settings),
          label: 'Settings',
        ),
      ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const FeedsPage();
          case 1:
            return const SearchPage();
          case 2:
            return const SettingsPage();
          default:
            return const Center(
              child: Text('Page not found!'),
            );
        }
      },
    );
  }
}

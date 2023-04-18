import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum HomeScreenTabs { sightList, map, favorite, settings }

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenTabs _indexOfTab = HomeScreenTabs.sightList;
  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_indexOfTab) {
      case HomeScreenTabs.sightList:
        body = const SightListScreen();
        break;
      case HomeScreenTabs.settings:
        body = const SettingScreen();
        break;
      case HomeScreenTabs.favorite:
        body = const VisitingScreen();
        break;
      case HomeScreenTabs.map:
      default:
        body = const SizedBox.shrink();
        break;
    }
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _indexOfTab = HomeScreenTabs.values[value];
          });
        },
        currentIndex: _indexOfTab.index,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            activeIcon: SvgPicture.asset(
              AppAssets.listFilled,
              color: themeProvider.appTheme.bottomNavBarSelectedItemColor,
            ),
            label: 'List of Places',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map_outlined),
            activeIcon: SvgPicture.asset(
              AppAssets.mapFilled,
              color: themeProvider.appTheme.bottomNavBarSelectedItemColor,
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.like,
              color: themeProvider.appTheme.bottomNavBarUnselectedItemColor,
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.likeFilled,
              color: themeProvider.appTheme.bottomNavBarSelectedItemColor,
            ),
            label: 'Favorite places',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

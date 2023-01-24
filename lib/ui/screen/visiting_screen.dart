// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/favorite_card.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({super.key});

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: const _FavoriteAppBar(),
          body: TabBarView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  FavoriteSight(
                    sight: mocks[0],
                    isFinished: false,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 30),
                  FavoriteSight(
                    sight: mocks[1],
                    isFinished: true,
                  ),
                ],
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 2,
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
                  color: themeProvider.appTheme.bottomNavBarSelectedItemColor,
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
        ));
  }
}

class _FavoriteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _FavoriteAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title:
          const Text(AppStrings.favoritePlaces, style: AppTypography.subtitle),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: themeProvider.appTheme.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(40.0)),
            child: TabBar(
              splashBorderRadius: const BorderRadius.all(Radius.circular(40.0)),
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              tabs: [
                const Text(AppStrings.wouldLikeToVisit),
                const Text(AppStrings.justVisited),
              ],
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 108);
}

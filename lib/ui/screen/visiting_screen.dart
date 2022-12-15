// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_colors.dart';
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text("Избранное", style: AppTypography.subtitle),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: _appTabBar().preferredSize,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Material(
                  color: AppColors.background,
                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                  child: _appTabBar(),
                ),
              )),
        ),
        body: TabBarView(children: [
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
              )
            ],
          )
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.whiteSecondary,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: "List of Places"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined), label: "Map"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded), label: "Favorite places"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: "Settings"),
          ],
        ),
      ),
    );
  }
}

// ТабБАр приложения
TabBar _appTabBar() {
  return const TabBar(
    indicator: BoxDecoration(
      color: AppColors.whiteSecondary,
      borderRadius: BorderRadius.all(
        Radius.circular(40.0),
      ),
    ),
    unselectedLabelColor: AppColors.whiteSecondary2,
    unselectedLabelStyle: AppTypography.smallBoldwhite,
    labelStyle: AppTypography.smallBoldwhite,
    labelColor: AppColors.white,
    labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    tabs: [
      Text(AppStrings.wouldLikeToVisit),
      Text(AppStrings.justVisited),
    ],
  );
}

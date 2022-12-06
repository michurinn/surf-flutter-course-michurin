// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places/mocks.dart';
import 'package:places/res/AppColors.dart';
import 'package:places/res/AppTypography.dart';
import 'package:places/ui/screen/favorite_card.dart';
import 'package:places/ui/screen/finished_card.dart';

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
                  preferredSize: _tabBar().preferredSize,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      color: AppColors.background,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40.0)),
                      child: _tabBar(),
                    ),
                  )),
            ),
            body: TabBarView(children: [
              Column(
                children: [
                  const SizedBox(height: 30),
                  FavoriteSight(sight: mocks[0])
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 30),
                  FinishedSight(sight: mocks[1])
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
                      icon: Icon(Icons.favorite_rounded),
                      label: "Favorite places"),
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.settings_outlined), label: "Settings")
                ])));
  }

  TabBar _tabBar() {
    return const TabBar(
        indicator: BoxDecoration(
            color: AppColors.whiteSecondary,
            borderRadius: BorderRadius.all(Radius.circular(40.0))),
        unselectedLabelColor: AppColors.whiteSecondary2,
        unselectedLabelStyle: AppTypography.smallBoldwhite,
        labelStyle: AppTypography.smallBoldwhite,
        labelColor: AppColors.white,
        labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        tabs: [Text("Хочу посетить"), Text("Посетил")]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

// Екран списка мест
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: _AppBar(),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const FilterScreen()),
                      );
                    },
                    child: Text(AppStrings.addToCalendar),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const SightSearchScreen()),
                    ),
                    child: const SearchBar(
                      isEnabled: false,
                      isFocused: false,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: mocks
                        .expand((e) =>
                            [SightCard(sight: e), const SizedBox(height: 20)])
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 16),
            child: _AddButton(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        AppStrings.listOfInterestingPlases,
        style: AppTypography.subtitle,
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddSightScreen(),
          ),
        );
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 0.0, color: Colors.transparent),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0.0),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: themeProvider.appTheme.newPlaceButton),
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        ),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.plus_one,
                  size: 20, color: themeProvider.appTheme.addFormActiveLabel),
              const SizedBox(
                width: 10,
              ),
              Text(
                AppStrings.create.toUpperCase(),
                style: AppTypography.button
                    .copyWith(color: themeProvider.appTheme.addFormActiveLabel),
              )
            ],
          ),
        ),
      ),
    );
  }
}


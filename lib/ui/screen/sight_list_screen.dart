import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/sight_card.dart';

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
        preferredSize: Size.fromHeight(120),
        child: _AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: mocks
              .expand((e) => [SightCard(sight: e), const SizedBox(height: 20)])
              .toList(),
        ),
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
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            label: 'List of Places',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map_outlined),
            activeIcon: SvgPicture.asset(
              AppAssets.mapFilled,
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.like,
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.likeFilled,
              color:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
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
      toolbarHeight: 120,
      elevation: 0,
      title: const Text(
        AppStrings.listOfInterestingPlases,
        //style: AppTypography.largeTitle,
      ),
    );
  }
}

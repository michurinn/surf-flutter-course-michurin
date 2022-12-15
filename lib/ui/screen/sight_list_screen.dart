import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/res/app_strings.dart';

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
          children: _returnColumnFromMocks,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: AppColors.whiteSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'List of Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorite places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
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
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      elevation: 0,
      title: const Text(
        AppStrings.listOfInterestingPlases,
        style: AppTypography.largeTitle,
      ),
    );
  }
}

// Создаёт СПИСОК по карточкам mocks, разделённых SizedBox(height:20)
List<Widget> _returnColumnFromMocks = <Widget>[
  mocks[0],
  const SizedBox(height: 20),
  mocks[1],
  const SizedBox(height: 20),
  mocks[2],
];

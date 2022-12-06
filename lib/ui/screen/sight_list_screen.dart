import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/AppColors.dart';
import 'package:places/ui/screen/favorite_card.dart';
import 'package:places/ui/screen/finished_card.dart';
import 'package:places/ui/screen/sight_card.dart';
import '/res/AppTypography.dart';
import 'package:places/res/AppStrings.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
            toolbarHeight: 120,
            backgroundColor: ThemeData.light().scaffoldBackgroundColor,
            elevation: 0,
            title: const Text(
              AppStrings.listOfInterestingPlases,
              style: AppTypography.largeTitle,
            )),
      ),
      body:
          SingleChildScrollView(child: returnColumnFromList(inputList: mocks)),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.whiteSecondary,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: "List of Places"),
            BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined), label: "Map"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded), label: "Favorite places"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: "Settings"),
          ]),
    );
  }
}

// Создаёт Column из карт по списку mocks, разделённых SizedBox(height:20)
class returnColumnFromList extends StatelessWidget {
  returnColumnFromList({super.key, required this.inputList});
  final List inputList;
  List<Widget> returnedColumn = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < inputList.length; i++) {
      returnedColumn.add(FinishedSight(sight: inputList[i]));
      if (i != inputList.length - 1) {
        returnedColumn.add(const SizedBox(
          height: 20,
        ));
      }
    }
    return Column(
      children: returnedColumn,
    );
  }
}

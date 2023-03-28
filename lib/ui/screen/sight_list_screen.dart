import 'dart:io';

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
  // Храним здесь список, который будем отображать с учётом фильтров и поиска,
  // изменения из екранов поиска передаём через callback .then(...) навигатора
  late List<Sight> places;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // По умолчанию
    places = mocks;
    super.initState();
  }

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
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      // При тапе на виджет поиска переход на страницу поиска,
                      // а при тапе именно на иконку Icons.tune_rounded - переход на екран фильтров
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SightSearchScreen(
                                    filteredPlaces: places,
                                  )),
                        ),
                        child: const SearchBar(
                          isEnabled: false,
                          isFocused: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: Icon(Icons.tune_rounded,
                              color: themeProvider.appTheme.filterButtonColor),
                          onPressed: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                  builder: (context) => const FilterScreen()),
                            )
                                .then((value) {
                              //Теперь покажем только отфильтрованные места
                              if (value == null) return;
                              setState(
                                () {
                                  places = value;
                                },
                              );
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OverscrollGlowAbsorver(
                    child: ListOfPlaces(
                      places: places,
                      scrollController: _scrollController,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),

          // Кнопка Добавить
          Positioned(
            bottom: 16,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 90,
              ),
              child: _AddButton(
                onNewPlaceCreated: (() {
                  setState(
                    // Покажем обновлённый список
                    () {},
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(milliseconds: 500),
                      content: const Text(
                        AppStrings.newPlaceAdded,
                        style: AppTypography.simpleText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
              ),
            ),
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

class ListOfPlaces extends StatefulWidget {
  const ListOfPlaces({
    Key? key,
    required this.places,
    required this.scrollController,
  }) : super(key: key);

  final List<Sight> places;
  final ScrollController scrollController;
  @override
  State<ListOfPlaces> createState() => _ListOfPlacesState();
}

class _ListOfPlacesState extends State<ListOfPlaces> {
  late List<Sight> places;

  @override
  void initState() {
    super.initState();
    places = widget.places;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        controller: widget.scrollController,
        shrinkWrap: true,
        physics: Platform.isAndroid
            ? const ClampingScrollPhysics()
            : const BouncingScrollPhysics(),
        itemCount: places.length,
        itemBuilder: (context, index) {
          return DragTarget(
            onAccept: (data) {
              ValueKey<String> rawData = data as ValueKey<String>;

              setState(() {
                places.insert(
                  places.indexOf(places[index]),
                  places.removeAt(
                    places.indexWhere(
                      (element) => element.name == rawData.value.toString(),
                    ),
                  ),
                );
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Column(
                children: [
                  LongPressDraggable(
                    data: ValueKey<String>(places[index].name),
                    axis: Axis.vertical,
                    feedback: Opacity(
                      opacity: 0.8,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: SightCard(sight: places[index]),
                      ),
                    ),
                    child: SightCard(sight: places[index]),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          );
        },
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

// Кнопка Добавить новое место
class _AddButton extends StatelessWidget {
  final VoidCallback onNewPlaceCreated;

  const _AddButton({required this.onNewPlaceCreated});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => const AddSightScreen(),
          ),
        )
            .then(
          (value) {
            if (value == true) {
              onNewPlaceCreated();
            }
          },
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
          borderRadius: const BorderRadius.all(
            Radius.circular(24.0),
          ),
        ),
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
    );
  }
}

class OverscrollGlowAbsorver extends StatelessWidget {
  final Widget child;
  const OverscrollGlowAbsorver({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: child,
      onNotification: (notification) {
        if (notification is OverscrollIndicatorNotification) {
          notification.disallowIndicator();
        }
        return false;
      },
    );
  }
}

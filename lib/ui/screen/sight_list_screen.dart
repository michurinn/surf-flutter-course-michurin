import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

// Екран списка мест
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);
  static const routeName = 'sight_list_screen';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: _SightListScreenPersistantHeaderDelegate(
                      places: places,
                      repaint: (value) {
                        setState(() {
                          places = value;
                        });
                      },
                    ),
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
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
                    ]),
                  ),
                ],
              ),
              Positioned(
                bottom: 25,
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
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarSearchWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const _AppBarSearchWidget({
    Key? key,
    required this.places,
    required this.repaint,
  }) : super(key: key);

  final List<Sight> places;
  final Function(List<Sight> value) repaint;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            // При тапе на виджет поиска переход на страницу поиска,
            // а при тапе именно на иконку Icons.tune_rounded - переход на екран фильтров
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(SightSearchScreen.routeName, arguments: places),
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
                      .pushNamed(
                    FilterScreen.routeName,
                  )
                      .then((value) {
                    //Теперь покажем только отфильтрованные места
                    if (value is List<Sight>) {
                      repaint(value);
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
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
    return ListView.builder(
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
                  child: SightCard(
                    sight: places[index],
                    onTap: () => showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        isScrollControlled: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) => DraggableScrollableSheet(
                              expand: false,
                              snap: true,
                              maxChildSize: 0.95,
                              minChildSize: 0.9,
                              initialChildSize: 0.95,
                              builder: (context, scrollController) =>
                                  SightDetails(
                                sight: places[index],
                                scrollController: scrollController,
                              ),
                            )),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        );
      },
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
        Navigator.of(context).pushNamed(AddSightScreen.routeName).then(
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

class _SightListScreenPersistantHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  const _SightListScreenPersistantHeaderDelegate(
      {required this.places, required this.repaint});
  final List<Sight> places;
  final Function(List<Sight> value) repaint;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: themeProvider.appTheme.backgroundColor,
      child: Column(
        crossAxisAlignment: shrinkOffset < 100
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          shrinkOffset < 100
              ? Text(
                  AppStrings.listOfInterestingPlases,
                  style: AppTypography.largeTitle
                      .copyWith(color: themeProvider.appTheme.appTitle),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28.0),
                  child: Text(
                    AppStrings.listOfInterestingPlases
                        .replaceFirst(RegExp(r'\n'), ' '),
                    style: AppTypography.subtitle
                        .copyWith(color: themeProvider.appTheme.appTitle),
                  ),
                ),
          if (shrinkOffset == 0)
            _AppBarSearchWidget(
              places: places,
              repaint: (value) {
                repaint(value);
              },
            ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 155;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

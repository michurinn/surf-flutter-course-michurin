import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/main.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/dialogs/sight_details_bottom_sheet.dart';
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
  late List<Place> places;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    places = [];
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await placeInteractor.getPlaces().then((value) {
      setState(() {
        places = value;
      });
    });

    super.didChangeDependencies();
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
                    delegate: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? _SightListScreenPersistantHeaderDelegatePortrait(
                            places: places,
                            repaint: (value) {
                              setState(() {
                                places = value;
                              });
                            },
                          )
                        : _SightListScreenPersistantHeaderDelegateLandScape(
                            places: places,
                            repaint: (value) {
                              setState(() {
                                places = value;
                              });
                            },
                            onNewPlaceCreated: () {
                              setState(() {
                                //Покажем обновлённый список
                              });
                            },
                          ),
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      OverscrollGlowAbsorver(
                        child: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? ListOfPlacesVertical(
                                places: places,
                                scrollController: _scrollController,
                              )
                            : ListOfPlacesHorizontal(
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
                  portraitOrientation:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? true
                          : false,
                  onNewPlaceCreated: ((Place newPlace) async {
                    await placeInteractor.addNewPlace(newPlace);
                    setState(
                      // Покажем обновлённый список
                      () {},
                    );
                    if(mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(milliseconds: 500),
                        content: const Text(
                          AppStrings.newPlaceAdded,
                          style: AppTypography.simpleText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    }
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
  const _AppBarSearchWidget(
      {Key? key,
      required this.places,
      required this.repaint,
      this.tiny = false})
      : super(key: key);

  final List<Place>? places;
  final Function(List<Place> value) repaint;
  final bool tiny;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(tiny ? 30 : 40),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: tiny ? .0 : 5.0),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            // При тапе на виджет поиска переход на страницу поиска,
            // а при тапе именно на иконку Icons.tune_rounded - переход на екран фильтров
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(SightSearchScreen.routeName, arguments: places),
              child: tiny
                  ? const SizedBox(
                      height: 30,
                      child: SearchBar(
                        isEnabled: false,
                        isFocused: false,
                      ),
                    )
                  : const SearchBar(
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
                    if (value is List<Place>) {
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
  Size get preferredSize => Size.fromHeight(tiny ? 30 : 40);
}

//Содержимое (места), если ориентация горизонтальная
class ListOfPlacesHorizontal extends StatefulWidget {
  const ListOfPlacesHorizontal({
    Key? key,
    required this.places,
    required this.scrollController,
  }) : super(key: key);

  final List<Place> places;
  final ScrollController scrollController;
  @override
  State<ListOfPlacesHorizontal> createState() => _ListOfPlacesHorizontalState();
}

class _ListOfPlacesHorizontalState extends State<ListOfPlacesHorizontal> {
  late List<Place> places;

  @override
  void initState() {
    super.initState();
    places = widget.places;
  }

  @override
  void didUpdateWidget(covariant ListOfPlacesHorizontal oldWidget) {
    super.didUpdateWidget(oldWidget);
    places = widget.places;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      controller: widget.scrollController,
      shrinkWrap: true,
      physics: Platform.isAndroid
          ? const ClampingScrollPhysics()
          : const BouncingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      children: places
          .expand(
            (element) => [
              DragTarget(
                onAccept: (data) {
                  ValueKey<String> rawData = data as ValueKey<String>;
                  setState(() {
                    places.insert(
                      places.indexOf(element),
                      places.removeAt(
                        places.indexWhere(
                          (element) => element.name == rawData.value.toString(),
                        ),
                      ),
                    );
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return LongPressDraggable(
                    data: ValueKey<String>(element.name),
                    feedback: Opacity(
                      opacity: 0.8,
                      child: SizedBox(
                        width: 400 * 0.8,
                        height: 300 * 0.8,
                        child: SightCard(
                          sight: element,
                          isFavorite:
                              placeInteractor.favoritePlaces.contains(element),
                        ),
                      ),
                    ),
                    child: SightCard(
                      onHeartTap: () =>
                          placeInteractor.favoritePlaces.contains(element)
                              ? placeInteractor.removeFromFavorites(element)
                              : placeInteractor.addToFavorites(element),
                      isFavorite:
                          placeInteractor.favoritePlaces.contains(element),
                      sight: element,
                      onTap: () => showDetailsBottomSheet(context, element),
                    ),
                  );
                },
              )
            ],
          )
          .toList(),
    );
  }
}

//Содержимое (места), если ориентация вертикальная
class ListOfPlacesVertical extends StatefulWidget {
  const ListOfPlacesVertical({
    Key? key,
    required this.places,
    required this.scrollController,
  }) : super(key: key);

  final List<Place>? places;
  final ScrollController scrollController;
  @override
  State<ListOfPlacesVertical> createState() => _ListOfPlacesVerticalState();
}

class _ListOfPlacesVerticalState extends State<ListOfPlacesVertical> {
  late List<Place> places;

  @override
  void initState() {
    super.initState();
    places = widget.places ?? [];
  }

  @override
  void didUpdateWidget(covariant ListOfPlacesVertical oldWidget) {
    super.didUpdateWidget(oldWidget);
    places = widget.places ?? [];
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
                      child: SightCard(
                        sight: places[index],
                        isFavorite: placeInteractor.favoritePlaces
                            .contains(places[index]),
                      ),
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
                        builder: (context, scrollController) => SightDetails(
                          sight: places[index],
                          scrollController: scrollController,
                        ),
                      ),
                    ),
                    isFavorite:
                        placeInteractor.favoritePlaces.contains(places[index]),
                    onHeartTap: () =>
                        placeInteractor.favoritePlaces.contains(places[index])
                            ? placeInteractor.removeFromFavorites(places[index])
                            : placeInteractor.addToFavorites(places[index]),
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
  final Function(Place t) onNewPlaceCreated;
  //Для LandScape orientation вид изменится
  final bool portraitOrientation;
  const _AddButton(
      {required this.onNewPlaceCreated, this.portraitOrientation = true});
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(AddSightScreen.routeName).then(
          (value) {
            if (value is Place) {
              onNewPlaceCreated(value);
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
        constraints: portraitOrientation
            ? const BoxConstraints(maxWidth: 300.0, minHeight: 50.0)
            : const BoxConstraints(maxWidth: 50.0, minHeight: 50.0),
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
            if (portraitOrientation)
              const SizedBox(
                width: 10,
              ),
            if (portraitOrientation)
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

//Аппбар, если ориентация вертикальная
class _SightListScreenPersistantHeaderDelegatePortrait
    extends SliverPersistentHeaderDelegate {
  const _SightListScreenPersistantHeaderDelegatePortrait(
      {required this.places, required this.repaint});
  final List<Place>? places;
  final Function(List<Place> value) repaint;

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
//Аппбар, если ориентация горизонтальная

class _SightListScreenPersistantHeaderDelegateLandScape
    extends SliverPersistentHeaderDelegate {
  const _SightListScreenPersistantHeaderDelegateLandScape(
      {required this.places,
      required this.repaint,
      required this.onNewPlaceCreated});
  final List<Place>? places;
  final Function(List<Place> value) repaint;
  final VoidCallback onNewPlaceCreated;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: themeProvider.appTheme.backgroundColor,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppStrings.listOfInterestingPlases
                      .replaceFirst(RegExp(r'\n'), ' '),
                  style: AppTypography.subtitle
                      .copyWith(color: themeProvider.appTheme.appTitle),
                ),
              ),
              if (shrinkOffset == 0)
                _AppBarSearchWidget(
                  tiny: true,
                  places: places,
                  repaint: (value) {
                    repaint(value);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

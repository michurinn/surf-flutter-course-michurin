import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/main.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/dialogs/sight_details_bottom_sheet.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/domain/error_widget.dart' as error_widget;

// Екран списка мест
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);
  static const routeName = 'sight_list_screen';

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final ScrollController _scrollController = ScrollController();
  late StreamController<List<Place>> placesController;
  @override
  void initState() {
    placesController = StreamController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    placesController.close();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await placeInteractor.getPlaces().then((value) {
      placesController.add(value);
    }, onError: (error) => placesController.addError(error));
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
                    delegate: _SightListHeaderDelegate.fromScreenOrientation(
                      orientation: MediaQuery.of(context).orientation,
                      onPressed: () => Navigator.of(context)
                          .pushNamed(
                        FilterScreen.routeName,
                      )
                          .then((_) {
                        // Покажем результаты с фильтром, если установлен фильтр
                        if (searchInteractor.filteredPlaces.isNotEmpty) {
                          placesController.add(searchInteractor.filteredPlaces);
                        }
                      }),
                    ) as SliverPersistentHeaderDelegate,
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      OverscrollGlowAbsorver(
                        child: StreamBuilder<List<Place>>(
                            stream: placesController.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: error_widget.ErrorWidget(
                                    color: AppColors.inactiveBlack,
                                  ),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox.square(
                                  dimension: 200,
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                );
                              } else {
                                return _ListOfPlaces.fromScreenOrientation(
                                  orientation:
                                      MediaQuery.of(context).orientation,
                                  places: snapshot.hasData
                                      ? snapshot.data as List<Place>
                                      : [],
                                  scrollController: _scrollController,
                                ) as StatefulWidget;
                              }
                            }),
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
                    final response = await placeInteractor.getPlaces();
                    placesController.add(response);
                    if (mounted) {
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
      {Key? key, required this.onPressed, this.tiny = false})
      : super(key: key);

  final VoidCallback? onPressed;
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
              onTap: () =>
                  Navigator.of(context).pushNamed(SightSearchScreen.routeName),
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
                    color: themeInteractor.appTheme.filterButtonColor),
                onPressed: onPressed,
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

//Класс отображает интересные места в зависимости от ориентации екрана
abstract class _ListOfPlaces {
  factory _ListOfPlaces.fromScreenOrientation(
      {required Orientation orientation,
      required List<Place> places,
      required ScrollController scrollController}) {
    if (orientation == Orientation.portrait) {
      return _ListOfPlacesPortrait(
        places: places,
        scrollController: scrollController,
      );
    } else {
      return _ListOfPlacesLandScape(
        places: places,
        scrollController: scrollController,
      );
    }
  }
}

//Содержимое (места), если ориентация горизонтальная
class _ListOfPlacesLandScape extends StatefulWidget with _ListOfPlaces {
  const _ListOfPlacesLandScape({
    Key? key,
    required this.places,
    required this.scrollController,
  }) : super(key: key);

  final List<Place> places;
  final ScrollController scrollController;
  @override
  State<_ListOfPlacesLandScape> createState() => _ListOfPlacesLandScapeState();
}

class _ListOfPlacesLandScapeState extends State<_ListOfPlacesLandScape> {
  late List<Place> places;

  @override
  void initState() {
    super.initState();
    places = widget.places;
  }

  @override
  void didUpdateWidget(covariant _ListOfPlacesLandScape oldWidget) {
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
                          onHeartTap: () {
                            // No possible to tap in 'feedback' view
                          },
                          onTap: () {
                            // No possible to tap in 'feedback' view
                          },
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

//Содержимое (места), если ориентация портретная
class _ListOfPlacesPortrait extends StatefulWidget with _ListOfPlaces {
  const _ListOfPlacesPortrait({
    Key? key,
    required this.places,
    required this.scrollController,
  }) : super(key: key);

  final List<Place> places;
  final ScrollController scrollController;
  @override
  State<_ListOfPlacesPortrait> createState() => _ListOfPlacesPortraitState();
}

class _ListOfPlacesPortraitState extends State<_ListOfPlacesPortrait> {
  late List<Place> places;

  @override
  void initState() {
    super.initState();
    places = widget.places;
  }

  @override
  void didUpdateWidget(covariant _ListOfPlacesPortrait oldWidget) {
    super.didUpdateWidget(oldWidget);
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
                      child: SightCard(
                        sight: places[index],
                        isFavorite: placeInteractor.favoritePlaces
                            .contains(places[index]),
                        onHeartTap: () {
                          // No possible to tap in 'feedback' view
                        },
                        onTap: () {
                          // No possible to tap in 'feedback' view
                        },
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
              LinearGradient(colors: themeInteractor.appTheme.newPlaceButton),
          borderRadius: const BorderRadius.all(
            Radius.circular(24.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.plus_one,
                size: 20, color: themeInteractor.appTheme.addFormActiveLabel),
            if (portraitOrientation)
              const SizedBox(
                width: 10,
              ),
            if (portraitOrientation)
              Text(
                AppStrings.create.toUpperCase(),
                style: AppTypography.button.copyWith(
                    color: themeInteractor.appTheme.addFormActiveLabel),
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

//Класс отображает AppBar в зависимости от ориентации екрана
abstract class _SightListHeaderDelegate {
  factory _SightListHeaderDelegate.fromScreenOrientation(
      {required Orientation orientation, VoidCallback? onPressed}) {
    if (orientation == Orientation.portrait) {
      return _SightListScreenPersistantHeaderDelegatePortrait(
          onPressed: onPressed);
    } else {
      return _SightListScreenPersistantHeaderDelegateLandScape(
        onPressed: onPressed,
      );
    }
  }
}

//Аппбар, если ориентация вертикальная
class _SightListScreenPersistantHeaderDelegatePortrait
    extends SliverPersistentHeaderDelegate implements _SightListHeaderDelegate {
  const _SightListScreenPersistantHeaderDelegatePortrait(
      {required this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: themeInteractor.appTheme.backgroundColor,
      child: Column(
        crossAxisAlignment: shrinkOffset < 100
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          shrinkOffset < 100
              ? Text(
                  AppStrings.listOfInterestingPlases,
                  style: AppTypography.largeTitle
                      .copyWith(color: themeInteractor.appTheme.appTitle),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28.0),
                  child: Text(
                    AppStrings.listOfInterestingPlases
                        .replaceFirst(RegExp(r'\n'), ' '),
                    style: AppTypography.subtitle
                        .copyWith(color: themeInteractor.appTheme.appTitle),
                  ),
                ),
          if (shrinkOffset == 0)
            _AppBarSearchWidget(
              onPressed: onPressed,
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
    extends SliverPersistentHeaderDelegate with _SightListHeaderDelegate {
  const _SightListScreenPersistantHeaderDelegateLandScape({
    required this.onPressed,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: themeInteractor.appTheme.backgroundColor,
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
                      .copyWith(color: themeInteractor.appTheme.appTitle),
                ),
              ),
              if (shrinkOffset == 0)
                _AppBarSearchWidget(
                  tiny: true,
                  onPressed: onPressed,
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

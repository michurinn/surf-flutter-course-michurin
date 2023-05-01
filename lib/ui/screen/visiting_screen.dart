import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/favorite_card.dart';

// Екран Хочу посетить/Посещённые
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({super.key});
  static const routeName = 'visiting_screen';

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  final List<Place> favoritePlaces =
      placeInteractor.getFavoritePlacesSortedByDistance();
  final List<Place> visitedPlaces = placeInteractor.visitedPlaces;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: const _FavoriteAppBar(),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    _FavoriteSightMocks(favoritePlaces: favoritePlaces),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    _FavoriteSightMocks(favoritePlaces: visitedPlaces),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _FavoriteSightMocks extends StatefulWidget {
  const _FavoriteSightMocks({
    Key? key,
    required this.favoritePlaces,
  }) : super(key: key);
  final List<Place> favoritePlaces;
  @override
  State<_FavoriteSightMocks> createState() => _FavoriteSightMocksState();
}

class _FavoriteSightMocksState extends State<_FavoriteSightMocks> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          physics: Platform.isAndroid
              ? const ClampingScrollPhysics()
              : const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.favoritePlaces.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Card(
                    child: Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        color: themeProvider.appTheme.errorColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.bucket,
                              color: AppColors.white,
                              width: 22,
                              height: 22,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppStrings.delete,
                              style: AppTypography.small
                                  .copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Dismissible(
                  key: ValueKey<int>(widget.favoritePlaces[index].hashCode),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    placeInteractor
                        .removeFromFavorites(widget.favoritePlaces[index]);
                    setState(() {});
                  },
                  child: DragTarget(
                    onAccept: (data) {
                      ValueKey<String> rawData = data as ValueKey<String>;

                      setState(() {
                        placeInteractor.favoritePlaces.insert(
                          placeInteractor.favoritePlaces
                              .indexOf(placeInteractor.favoritePlaces[index]),
                          placeInteractor.favoritePlaces.removeAt(
                            placeInteractor.favoritePlaces.indexWhere(
                              (element) =>
                                  element.name == rawData.value.toString(),
                            ),
                          ),
                        );
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Column(
                        children: [
                          LongPressDraggable(
                            data: ValueKey<String>(
                                widget.favoritePlaces[index].name),
                            axis: Axis.vertical,
                            feedback: Opacity(
                              opacity: 0.8,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: FavoriteSight(
                                  sight: widget.favoritePlaces[index],
                                  isFinished: false,
                                  onClosePressed: () =>
                                      placeInteractor.removeFromFavorites(
                                          widget.favoritePlaces[index]),
                                ),
                              ),
                            ),
                            child: FavoriteSight(
                              sight: widget.favoritePlaces[index],
                              isFinished: false,
                              onClosePressed: () {
                                placeInteractor.removeFromFavorites(
                                      widget.favoritePlaces[index]);
                                      setState(() {
                                        
                                      });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class _FavoriteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _FavoriteAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title:
          const Text(AppStrings.favoritePlaces, style: AppTypography.subtitle),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: themeProvider.appTheme.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(40.0)),
            child: TabBar(
              splashBorderRadius: const BorderRadius.all(Radius.circular(40.0)),
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              tabs: const [
                Text(AppStrings.wouldLikeToVisit),
                Text(AppStrings.justVisited),
              ],
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 108);
}

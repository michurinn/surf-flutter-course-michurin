import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/bloc/planned_bloc/planned_places_bloc.dart';
import 'package:places/data/bloc/visited_bloc/bloc/visited_places_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/place_planned.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/favorite_card.dart';
import 'package:provider/provider.dart';

// Екран Хочу посетить/Посещённые
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({super.key});
  static const routeName = 'visiting_screen';

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
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
                    BlocBuilder<PlannedPlacesBloc, PlannedPlacesState>(
                      builder: (context, state) {
                        return state.map(
                          loaded: (value) => _PlannedPlaces(
                              plannedPlaces: value.favoritePlaces),
                          loading: (value) =>
                              const CircularProgressIndicator.adaptive(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    BlocBuilder<VisitedPlacesBloc, VisitedPlacesState>(
                      builder: (context, state) {
                        return state.map(
                          loaded: (value) => _VisitedPlaces(
                              favoritePlaces: value.visitedPlaces),
                          loading: (value) =>
                              const CircularProgressIndicator.adaptive(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _PlannedPlaces extends StatefulWidget {
  const _PlannedPlaces({
    Key? key,
    required this.plannedPlaces,
  }) : super(key: key);
  final List<PlacePlanned> plannedPlaces;
  @override
  State<_PlannedPlaces> createState() => _PlannedPlacesState();
}

class _PlannedPlacesState extends State<_PlannedPlaces> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          physics: Platform.isAndroid
              ? const ClampingScrollPhysics()
              : const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.plannedPlaces.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Card(
                    child: Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        color: context
                            .watch<SettingsInteractor>()
                            .appTheme
                            .errorColor,
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
                  key: ValueKey<int>(widget.plannedPlaces[index].hashCode),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context
                        .read<PlannedPlacesBloc>().add(event);
                        
                  },
                  child: DragTarget(
                    onAccept: (data) {
                      ValueKey<String> rawData = data as ValueKey<String>;

                      setState(() {
                        context.read<PlaceInteractor>().favoritePlaces.insert(
                              context
                                  .read<PlaceInteractor>()
                                  .favoritePlaces
                                  .indexOf(context
                                      .read<PlaceInteractor>()
                                      .favoritePlaces[index]),
                              context
                                  .read<PlaceInteractor>()
                                  .favoritePlaces
                                  .removeAt(
                                    context
                                        .read<PlaceInteractor>()
                                        .favoritePlaces
                                        .indexWhere(
                                          (element) =>
                                              element.name ==
                                              rawData.value.toString(),
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
                                widget.plannedPlaces[index].name),
                            axis: Axis.vertical,
                            feedback: Opacity(
                              opacity: 0.8,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: FavoriteSight(
                                  sight: widget.plannedPlaces[index],
                                  isFinished: false,
                                  onClosePressed: () => context
                                      .read<PlaceInteractor>()
                                      .removeFromFavorites(
                                          widget.plannedPlaces[index]),
                                ),
                              ),
                            ),
                            child: FavoriteSight(
                              sight: widget.plannedPlaces[index],
                              isFinished: false,
                              onClosePressed: () {
                                context
                                    .read<PlaceInteractor>()
                                    .removeFromFavorites(
                                        widget.plannedPlaces[index]);
                                setState(() {});
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


class _VisitedPlaces extends StatefulWidget {
  const _VisitedPlaces({
    Key? key,
    required this.favoritePlaces,
  }) : super(key: key);
  final List<Place> favoritePlaces;
  @override
  State<_VisitedPlaces> createState() => _VisitedPlacesState();
}

class _VisitedPlacesState extends State<_VisitedPlaces> {
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
                        color: context
                            .watch<SettingsInteractor>()
                            .appTheme
                            .errorColor,
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
                    context
                        .read<PlaceInteractor>()
                        .removeFromFavorites(widget.favoritePlaces[index]);
                    setState(() {});
                  },
                  child: DragTarget(
                    onAccept: (data) {
                      ValueKey<String> rawData = data as ValueKey<String>;

                      setState(() {
                        context.read<PlaceInteractor>().favoritePlaces.insert(
                              context
                                  .read<PlaceInteractor>()
                                  .favoritePlaces
                                  .indexOf(context
                                      .read<PlaceInteractor>()
                                      .favoritePlaces[index]),
                              context
                                  .read<PlaceInteractor>()
                                  .favoritePlaces
                                  .removeAt(
                                    context
                                        .read<PlaceInteractor>()
                                        .favoritePlaces
                                        .indexWhere(
                                          (element) =>
                                              element.name ==
                                              rawData.value.toString(),
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
                                  onClosePressed: () => context
                                      .read<PlaceInteractor>()
                                      .removeFromFavorites(
                                          widget.favoritePlaces[index]),
                                ),
                              ),
                            ),
                            child: FavoriteSight(
                              sight: widget.favoritePlaces[index],
                              isFinished: false,
                              onClosePressed: () {
                                context
                                    .read<PlaceInteractor>()
                                    .removeFromFavorites(
                                        widget.favoritePlaces[index]);
                                setState(() {});
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
    final themeProvider = context.watch<SettingsInteractor>().appTheme;
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
            color: themeProvider.cardColor,
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

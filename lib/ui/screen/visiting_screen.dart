import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/bloc/planned_bloc/planned_places_bloc.dart';
import 'package:places/data/bloc/visited_bloc/bloc/visited_places_bloc.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/place_visited.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/favorite_card.dart';

// Екран Хочу посетить/Посещённые
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);
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
                      return state.when(
                        loaded: (favoritePlaces) =>
                            _PlannedPlaces(plannedPlaces: favoritePlaces),
                        loading: () =>
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
                        loaded: (value) =>
                            _VisitedPlaces(visitedPlaces: value.visitedPlaces),
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
      ),
    );
  }
}

class _PlannedPlaces extends StatelessWidget {
  const _PlannedPlaces({
    Key? key,
    required this.plannedPlaces,
  }) : super(key: key);
  final List<Place> plannedPlaces;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          physics: Platform.isAndroid
              ? const ClampingScrollPhysics()
              : const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: plannedPlaces.length,
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
                  key: ValueKey<int>(plannedPlaces[index].id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<PlannedPlacesBloc>().add(
                          PlannedPlacesEvent.remove(
                              placePlanned: plannedPlaces[index]),
                        );
                  },
                  child: DragTarget(
                    key: ValueKey<int>(plannedPlaces[index].id),
                    onAccept: (data) {
                      ValueKey<int> rawData = data as ValueKey<int>;
                      //TODO(me): Поразбираться, возможно путаница  в функции
                      context.read<PlannedPlacesBloc>().add(
                            PlannedPlacesEvent.swipe(
                                draggedPlaceId: rawData.value,
                                targetPlaceId: plannedPlaces[index].id),
                          );
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Column(
                        children: [
                          LongPressDraggable(
                            key: ValueKey<int>(plannedPlaces[index].id),
                            data: ValueKey<int>(plannedPlaces[index].id),
                            axis: Axis.vertical,
                            feedback: Opacity(
                              opacity: 0.8,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: FavoriteSight(
                                    sight: plannedPlaces[index],
                                    isFinished: false,
                                    onClosePressed:
                                        () {} // На feedback не нужна возможность нажимать крестик
                                    ),
                              ),
                            ),
                            child: FavoriteSight(
                              sight: plannedPlaces[index],
                              isFinished: false,
                              onClosePressed: () {
                                context.read<PlannedPlacesBloc>().add(
                                      PlannedPlacesEvent.remove(
                                          placePlanned: plannedPlaces[index]),
                                    );
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

class _VisitedPlaces extends StatelessWidget {
  const _VisitedPlaces({
    Key? key,
    required this.visitedPlaces,
  }) : super(key: key);
  final List<PlaceVisited> visitedPlaces;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          physics: Platform.isAndroid
              ? const ClampingScrollPhysics()
              : const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: visitedPlaces.length,
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
                  key: ValueKey<int>(visitedPlaces[index].hashCode),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    context.read<VisitedPlacesBloc>().add(
                          VisitedPlacesEvent.remove(
                              visitedPlace: visitedPlaces[index]),
                        );
                  },
                  child: DragTarget(
                    onAccept: (data) {
                      ValueKey<int> rawData = data as ValueKey<int>;
                      context.read<VisitedPlacesBloc>().add(
                            VisitedPlacesEvent.swipe(
                                draggedPlaceId: rawData.value,
                                targetPlaceId: visitedPlaces[index].id),
                          );
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Column(
                        children: [
                          LongPressDraggable(
                            data: ValueKey<int>(visitedPlaces[index].id),
                            axis: Axis.vertical,
                            feedback: Opacity(
                              opacity: 0.8,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: FavoriteSight(
                                  sight: visitedPlaces[index],
                                  isFinished: false,
                                  onClosePressed:
                                      () {}, // На feedback не нужна возможность нажимать крестик
                                ),
                              ),
                            ),
                            child: FavoriteSight(
                              sight: visitedPlaces[index],
                              isFinished: false,
                              onClosePressed: () {
                                context.read<VisitedPlacesBloc>().add(
                                      VisitedPlacesEvent.remove(
                                          visitedPlace: visitedPlaces[index]),
                                    );
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
            borderRadius: const BorderRadius.all(
              Radius.circular(40.0),
            ),
            child: TabBar(
              splashBorderRadius: const BorderRadius.all(
                Radius.circular(40.0),
              ),
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

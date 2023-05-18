// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:provider/provider.dart';

class SightDetails extends StatelessWidget {
  const SightDetails({
    Key? key,
    required this.sight,
    required this.scrollController,
  }) : super(key: key);
  static const routeName = 'sight_details_screen';

  final Place sight;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            _HeadWithImage(
              sight: sight,
            ),
            SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: _DetailsScreenPersistantHeaderDelegate(
                  sight: sight,
                )),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                _BodyWithTexts(sight: sight),
                const Flexible(
                  child: Spacer(),
                ),
                const Spacer(),
                _BottomWithButtons(
                    isFavorite: context
                        .watch<PlaceInteractor>()
                        .favoritePlaces
                        .contains(sight),
                    onFavoriteTap: () => context
                            .watch<PlaceInteractor>()
                            .favoritePlaces
                            .contains(sight)
                        ? context
                            .read<PlaceInteractor>()
                            .removeFromFavorites(sight)
                        : context
                            .read<PlaceInteractor>()
                            .addToFavorites(sight)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// Картинка места и кнопка Назад для sight_details
class _HeadWithImage extends StatelessWidget {
  const _HeadWithImage({Key? key, required this.sight}) : super(key: key);

  final Place sight;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<SettingsInteractor>().appTheme;
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 16.0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0),
              backgroundColor: themeProvider.cardColor,
              fixedSize: const Size(32, 32),
              alignment: Alignment.center,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              AppAssets.cancel,
              color: themeProvider.cardIconColor,
            ),
          ),
        ),
      ],
      expandedHeight: 360,
      flexibleSpace: Scrollbar(
        thumbVisibility: true,
        child: Container(
          decoration: BoxDecoration(
            color: themeProvider.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              PageView(
                  children: sight.urls
                      .expand(
                        (element) => <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(element, fit: BoxFit.cover),
                          )
                        ],
                      )
                      .toList()),
              Positioned(
                top: 12,
                child: SvgPicture.asset(
                  AppAssets.minimize,
                  color: AppColors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Тексты Название места и пр. для sight_details
class _BodyWithTexts extends StatefulWidget {
  const _BodyWithTexts({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Place sight;

  @override
  State<_BodyWithTexts> createState() => _BodyWithTextsState();
}

class _BodyWithTextsState extends State<_BodyWithTexts> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<SettingsInteractor>().appTheme;
    return Container(
      color: themeProvider.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future:
              context.watch<PlaceInteractor>().getPlaceDetails(widget.sight.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              default:
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(snapshot.data ?? '',
                          style: AppTypography.smallBlueDeep),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}

// Кнопки Построить маршрут,запланировать, В избранное для sight_details
class _BottomWithButtons extends StatefulWidget {
  const _BottomWithButtons({
    Key? key,
    this.onFavoriteTap,
    required this.isFavorite,
  }) : super(key: key);
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  @override
  State<_BottomWithButtons> createState() => _BottomWithButtonsState();
}

class _BottomWithButtonsState extends State<_BottomWithButtons> {
  late bool isFavorite;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<SettingsInteractor>().appTheme;
    return Container(
      color: themeProvider.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                print("Route button on card pressed");
              },
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                backgroundColor: context
                    .watch<SettingsInteractor>()
                    .appTheme
                    .routeButtonColor,
                minimumSize: const Size(328, 48),
                alignment: Alignment.center,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.route,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppStrings.buildRoute.toUpperCase(),
                    style: AppTypography.button,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      print("Calendar button pressed");
                    },
                    style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(0, 40)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.calendar,
                          width: 22,
                          height: 19,
                          color: context
                              .watch<SettingsInteractor>()
                              .appTheme
                              .bottomNavBarSelectedItemColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppStrings.addToCalendar,
                          style: AppTypography.small.copyWith(
                            color: context
                                .watch<SettingsInteractor>()
                                .appTheme
                                .bottomNavBarSelectedItemColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      widget.onFavoriteTap!();
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(0, 40)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          isFavorite ? AppAssets.likeFilled : AppAssets.like,
                          width: 20,
                          height: 20,
                          color: context
                              .watch<SettingsInteractor>()
                              .appTheme
                              .bottomNavBarSelectedItemColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          isFavorite
                              ? AppStrings.inFavoriteAlready
                              : AppStrings.inFavorite,
                          style: AppTypography.small.copyWith(
                            color: context
                                .watch<SettingsInteractor>()
                                .appTheme
                                .bottomNavBarSelectedItemColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsScreenPersistantHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final Place sight;
  const _DetailsScreenPersistantHeaderDelegate({required this.sight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final themeProvider = context.watch<SettingsInteractor>().appTheme;
    return Container(
      alignment: Alignment.centerLeft,
      color: themeProvider.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(sight.name, style: AppTypography.title)),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(sight.placeType.toString(),
                    style: AppTypography.smallBoldBlue),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  'WORK TIME MOCK',
                  style: AppTypography.small,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

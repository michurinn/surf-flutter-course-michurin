// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/place.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

class SightDetails extends StatelessWidget {
  const SightDetails(
      {Key? key, required this.sight, required this.scrollController})
      : super(key: key);
  static const routeName = 'sight_details_screen';

  final Place sight;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
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
            delegate: SliverChildListDelegate([
              _BodyWithTexts(sight: sight),
              Container(
                color: themeInteractor.appTheme.backgroundColor,
                height: 24,
              ),
              const _BottomWithButtons(),
            ]),
          ),
        ],
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
              backgroundColor: themeInteractor.appTheme.cardColor,
              fixedSize: const Size(32, 32),
              alignment: Alignment.center,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              AppAssets.cancel,
              color: themeInteractor.appTheme.cardIconColor,
            ),
          ),
        ),
      ],
      expandedHeight: 360,
      flexibleSpace: Scrollbar(
        thumbVisibility: true,
        child: Container(
          decoration: BoxDecoration(
            color: themeInteractor.appTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              PageView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(sight.urls[0], fit: BoxFit.cover),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(sight.urls[0], fit: BoxFit.cover),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(sight.urls[0], fit: BoxFit.cover),
                  ),
                ],
              ),
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
class _BodyWithTexts extends StatelessWidget {
  const _BodyWithTexts({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Place sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeInteractor.appTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(sight.description * 33,
                  style: AppTypography.smallBlueDeep),
            ),
          ],
        ),
      ),
    );
  }
}

// Кнопки Построить маршрут,запланировать, В избранное для sight_details
class _BottomWithButtons extends StatelessWidget {
  const _BottomWithButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeInteractor.appTheme.backgroundColor,
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
                backgroundColor: themeInteractor.appTheme.routeButtonColor,
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
                          color: themeInteractor
                              .appTheme.bottomNavBarSelectedItemColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppStrings.addToCalendar,
                          style: AppTypography.small.copyWith(
                            color: themeInteractor
                                .appTheme.bottomNavBarSelectedItemColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      print("Like button pressed");
                    },
                    style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(0, 40)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.heart,
                          width: 20,
                          height: 20,
                          color: themeInteractor
                              .appTheme.bottomNavBarSelectedItemColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppStrings.inFavorite,
                          style: AppTypography.small.copyWith(
                            color: themeInteractor
                                .appTheme.bottomNavBarSelectedItemColor,
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
    return Container(
      alignment: Alignment.centerLeft,
      color: themeInteractor.appTheme.backgroundColor,
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
                Text(sight.placeType.toString(), style: AppTypography.smallBoldBlue),
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

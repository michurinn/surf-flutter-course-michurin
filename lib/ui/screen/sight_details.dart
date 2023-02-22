// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

class SightDetails extends StatelessWidget {
  const SightDetails({Key? key, required this.sight}) : super(key: key);
  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _HeadWithImage(sight: sight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                _BodyWithTexts(sight: sight),
                const SizedBox(
                  height: 24,
                ),
                const _BottomWithButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Картинка места и кнопка Назад для sight_details
class _HeadWithImage extends StatelessWidget {
  const _HeadWithImage({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 360,
          child: Image.network(sight.imagePath, fit: BoxFit.fitHeight),
        ),
        Positioned(
          left: 16,
          top: 36,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(0),
              backgroundColor: themeProvider.appTheme.cardColor,
              minimumSize: const Size(32, 32),
              maximumSize: const Size(32, 32),
              alignment: Alignment.center,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              AppAssets.back,
              color: themeProvider.appTheme.cardIconColor,
              width: 5,
              height: 10,
            ),
          ),
        ),
      ],
    );
  }
}

// Тексты Название места и пр. для sight_details
class _BodyWithTexts extends StatelessWidget {
  const _BodyWithTexts({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(sight.name, style: AppTypography.title)),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(sight.type, style: AppTypography.smallBoldBlue),
            const SizedBox(
              width: 16,
            ),
            Text(
              sight.workTime,
              style: AppTypography.small,
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(sight.details, style: AppTypography.smallBlueDeep)),
      ],
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
    return Column(
      children: [
        OutlinedButton(
          onPressed: () {
            print("Route button on card pressed");
          },
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            backgroundColor: themeProvider.appTheme.routeButtonColor,
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
                      color:
                          themeProvider.appTheme.bottomNavBarSelectedItemColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppStrings.addToCalendar,
                      style: AppTypography.small.copyWith(
                        color: themeProvider
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
                  print("Like button   pressed");
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
                      color:
                          themeProvider.appTheme.bottomNavBarSelectedItemColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppStrings.inFavorite,
                      style: AppTypography.small.copyWith(
                        color: themeProvider
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
    );
  }
}

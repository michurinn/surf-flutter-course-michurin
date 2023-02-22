// ignore_for_file: avoid_print, camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

late final StreamController<bool> controller;

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

// Екран фильтров
class _FilterScreenState extends State<FilterScreen> {
  double _endValue = 9;
  double _startValue = 2;

  @override
  void initState() {
    controller = StreamController<bool>.broadcast();
    results = mocks;
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  Text _getRangeLabel(double startValue, double endValue) {
    return startValue < 1.0
        ? // Отсчёт начинаетс от 100 м, затем в км
        Text(
            "от 100 м до ${endValue.toInt()} км",
            style: AppTypography.simpleText
                .copyWith(color: AppColors.whiteSecondary2),
          )
        : Text(
            "от ${startValue.toInt()} км до ${endValue.toInt()} км",
            style: AppTypography.simpleText
                .copyWith(color: AppColors.whiteSecondary2),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            side: BorderSide.none,
            padding: const EdgeInsets.all(0),
            backgroundColor: themeProvider.appTheme.backgroundColor,
            minimumSize: const Size(32, 32),
            maximumSize: const Size(32, 32),
            alignment: Alignment.center,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppAssets.back,
            color: themeProvider.appTheme.cardIconColor,
            width: 5,
            height: 10,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _endValue = 9;
                  _startValue = 2;
                  controller.sink.add(false);
                });
              },
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(72, 20)),
              ),
              child: Text(
                AppStrings.clearIt,
                style: AppTypography.simpleText.copyWith(
                  color: themeProvider.appTheme.clearButtonColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 24,
                    top: 24,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.categories.toUpperCase(),
                      style: AppTypography.simpleText.copyWith(
                        color: AppColors.inactiveBlack,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 265,
                  child: _GridView(),
                ),
                const SizedBox(
                  height: 56,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppStrings.distance,
                      style: AppTypography.simpleText,
                    ),
                    _getRangeLabel(_startValue, _endValue),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                SliderTheme(
                  data: SliderThemeData(
                    thumbColor: AppColors.white,
                    disabledThumbColor: AppColors.white,
                    activeTrackColor: themeProvider.appTheme.routeButtonColor,
                    trackHeight: 2,
                  ),
                  child: RangeSlider(
                    divisions: 10,
                    inactiveColor: AppColors.inactiveBlack,
                    values: RangeValues(_startValue, _endValue),
                    onChanged: (values) {
                      setState(() {
                        _startValue = values.start;
                        _endValue = values.end;
                      });
                    },
                    min: 0,
                    max: 10,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: OutlinedButton(
                onPressed: () {
                  print("Show button pressed");
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
                    Text(
                      "Показать (${results!.length})".toUpperCase(),
                      style: AppTypography.button,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridView extends StatefulWidget {
  const _GridView({Key? key}) : super(key: key);

  @override
  State<_GridView> createState() => __GridViewState();
}

class __GridViewState extends State<_GridView> {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: _itemsList,
    );
  }
}

class _itemGridView extends StatefulWidget {
  final String iconAssetPath;
  final String text;
  const _itemGridView({required this.iconAssetPath, required this.text});

  @override
  State<_itemGridView> createState() => __itemGridViewState();
}

class __itemGridViewState extends State<_itemGridView> {
  bool isChecked = false;
  late final subscription;
  @override
  void initState() {
    subscription = controller.stream.listen((bool data) {
      setState(() {
        isChecked = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    color: themeProvider.appTheme.clearButtonColor
                        .withOpacity(0.16),
                    shape: BoxShape.circle),
                child: SvgPicture.asset(
                  widget.iconAssetPath,
                  fit: BoxFit.none,
                ),
              ),
              if (isChecked)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        color: themeProvider.appTheme.badgeColors[0],
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.done,
                      size: 10,
                      color: themeProvider.appTheme.badgeColors[1],
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(widget.text,
              style: AppTypography.superSmall.copyWith(
                  color: themeProvider.appTheme.bottomNavBarSelectedItemColor)),
        ],
      ),
    );
  }
}

List<_itemGridView> _itemsList = [
  const _itemGridView(
    iconAssetPath: 'assets/icons/hotel.svg',
    text: AppStrings.sightType2,
  ),
  const _itemGridView(
    iconAssetPath: 'assets/icons/restraunt.svg',
    text: AppStrings.sightType3,
  ),
  const _itemGridView(
    iconAssetPath: 'assets/icons/unique_place.svg',
    text: AppStrings.sightType4,
  ),
  const _itemGridView(
    iconAssetPath: 'assets/icons/park.svg',
    text: AppStrings.sightType5,
  ),
  const _itemGridView(
    iconAssetPath: 'assets/icons/museum.svg',
    text: AppStrings.sightType6,
  ),
  const _itemGridView(
    iconAssetPath: 'assets/icons/cafe.svg',
    text: AppStrings.sightType7,
  ),
];

List<Sight>? results;

void _cutResults(String type)
{
  results!.retainWhere((element) => element.type != type);
}
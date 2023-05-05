// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/place.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

//Екран Фильтров
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  static const routeName = 'filters_screen';

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

// Екран фильтров
class _FilterScreenState extends State<FilterScreen> {
  double _endValue = 9; // Конечное значение слайдера по умолчанию
  double _startValue = 2; // Начальное значение слайдера по умолчанию
  List<Place> results = searchInteractor.filteredPlaces;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    results = await searchInteractor.searchByFilter() ?? [];
  }

  @override
  void initState() {
    super.initState();
    searchInteractor.setFilter(
        radius:
            _endValue*2000); // Радиус поиска и верхняя граница слайдера совпадают по определнию
  }

  // Отсчёт начинаетс от 100 м, затем в км
  Text _getRangeLabel(double startValue, double endValue) {
    return startValue < 1.0
        ? Text(
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
            backgroundColor: themeInteractor.appTheme.backgroundColor,
            minimumSize: const Size(32, 32),
            maximumSize: const Size(32, 32),
            alignment: Alignment.center,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppAssets.back,
            color: themeInteractor.appTheme.cardIconColor,
            width: 5,
            height: 10,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                searchInteractor.resetFilter();
                setState(() {
                  _endValue = 9;
                  _startValue = 2;
                });
              },
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(72, 20)),
              ),
              child: Text(
                AppStrings.clearIt,
                style: AppTypography.simpleText.copyWith(
                  color: themeInteractor.appTheme.clearButtonColor,
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
                _GridView(
                  itemsList: SightType.values
                      .map(
                        (e) {
                          return _itemGridView(
                          isChecked: searchInteractor.favoriteCategories
                                  .contains(e.name)
                              ? true
                              : false,
                          onPressed: () async {
                            searchInteractor.setOrUnsetCategory(e.name);
                            final filteredResults =
                                await searchInteractor.searchByFilter() ?? [];
                            setState(() {
                              results = filteredResults;
                            });
                          },
                          sightType: e,
                        );
                        },
                      )
                      .toList(),
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
                    activeTrackColor: themeInteractor.appTheme.routeButtonColor,
                    trackHeight: 2,
                  ),
                  child: RangeSlider(
                    divisions: 10,
                    inactiveColor: AppColors.inactiveBlack,
                    values: RangeValues(_startValue, _endValue),
                    onChanged: (value) => setState(() {
                      _startValue = value.start;
                      _endValue = value.end;
                    }),
                    onChangeEnd: (_) async {
                      searchInteractor.setFilter(
                        radius: _endValue * 2000, // in kilometers
                      );
                      final filteredResults =
                          await searchInteractor.searchByFilter() ?? [];
                      setState(() {
                        results = filteredResults;
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
                  Navigator.pop(context, results);
                },
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  backgroundColor: themeInteractor.appTheme.routeButtonColor,
                  minimumSize: const Size(328, 48),
                  alignment: Alignment.center,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Показать (${results.length})".toUpperCase(),
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

// Сетка типов мест
class _GridView extends StatefulWidget {
  const _GridView({Key? key, required this.itemsList}) : super(key: key);
  final List<Widget> itemsList;
  @override
  State<_GridView> createState() => __GridViewState();
}

class __GridViewState extends State<_GridView> {
  @override
  Widget build(BuildContext context) {
    //Для маленьких екранов
    final bool isSmallScreen = MediaQuery.of(context).size.width < 400 &&
        MediaQuery.of(context).size.height <= 800;
    return isSmallScreen
        ? SizedBox(
            height: 105,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.itemsList
                  .expand((element) =>
                      [const SizedBox.square(dimension: 20), element])
                  .toList(),
            ),
          )
        : SizedBox(
            height: 265,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              children: widget.itemsList,
            ),
          );
  }
}

// Тип места
class _itemGridView extends StatefulWidget {
  final VoidCallback onPressed;
  final SightType sightType;
  final bool isChecked;
  const _itemGridView({
    required this.sightType,
    required this.onPressed,
    required this.isChecked,
  });

  @override
  State<_itemGridView> createState() => __itemGridViewState();
}

class __itemGridViewState extends State<_itemGridView> {
  late bool isChecked;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isChecked = widget.isChecked;
  }

  @override
  void didUpdateWidget(covariant _itemGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                    color: themeInteractor.appTheme.clearButtonColor
                        .withOpacity(0.16),
                    shape: BoxShape.circle),
                child: SvgPicture.asset(
                  widget.sightType.icon,
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
                        color: themeInteractor.appTheme.badgeColors[0],
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.done,
                      size: 10,
                      color: themeInteractor.appTheme.badgeColors[1],
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(widget.sightType.type,
              style: AppTypography.superSmall.copyWith(
                  color: themeInteractor.appTheme.bottomNavBarSelectedItemColor)),
        ],
      ),
    );
  }
}

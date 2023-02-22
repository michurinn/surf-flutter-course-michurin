import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

Map checkedMap = {for (var item in _listOfCategories) item: false};

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // По умолчанию ни один елемент не выбран

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppStrings.category,
          style: AppTypography.subtitle,
        ),
        leading: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 0.0, color: Colors.transparent),
            padding: const EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            minimumSize: const Size(32, 32),
            maximumSize: const Size(32, 32),
            alignment: Alignment.center,
          ),
          onPressed: () {
            // Категория не считается выбранной
            Navigator.of(context).pop(false);
          },
          child: SvgPicture.asset(
            AppAssets.back,
            color: themeProvider.appTheme.cardIconColor,
            width: 5,
            height: 10,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: _listOfCategories.map((element) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(
                      () {
                        // Может быть выбрана только одна категория, обнуляем прежний выбор
                        checkedMap.updateAll((key, value) => value = false);
                        checkedMap.update(element, (value) => value = !value);
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            element,
                            style: AppTypography.formLabel,
                          ),
                          Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                              (states) =>
                                  const BorderSide(color: Colors.transparent),
                            ),
                            checkColor: themeProvider.appTheme.routeButtonColor,
                            value: checkedMap[element],
                            onChanged: (value) {
                              setState(
                                () {
                                  // Может быть выбрана только одна категория, обнуляем прежний выбор
                                  checkedMap
                                      .updateAll((key, value) => value = false);
                                  checkedMap[element] = !checkedMap[element];
                                },
                              );
                            },
                          )
                        ],
                      ),
                      const Divider()
                    ],
                  ),
                );
              }).toList(),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _SaveButton(
                  isActive: checkedMap.containsValue(true),
                )),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatefulWidget {
  const _SaveButton({required this.isActive});
  final bool isActive;
  @override
  State<_SaveButton> createState() => __SaveButtonState();
}

class __SaveButtonState extends State<_SaveButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // Вернём название выбранной категории
        widget.isActive
            ? Navigator.of(context).pop(checkedMap.keys
                .firstWhere((element) => checkedMap[element] == true))
            : null;
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(width: 0.0, color: Colors.transparent),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        // Кнопка меняет цвет если не активна
        backgroundColor: widget.isActive
            ? themeProvider.appTheme.routeButtonColor
            : themeProvider.appTheme.cardColor,
        minimumSize: const Size(328, 48),
        alignment: Alignment.center,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.save.toUpperCase(),
            style: AppTypography.button.copyWith(
                color: widget.isActive
                    ? themeProvider.appTheme.addFormActiveLabel
                    : themeProvider.appTheme.addFormInactiveLabel),
          )
        ],
      ),
    );
  }
}

List<String> _listOfCategories = [
  AppStrings.sightType0,
  AppStrings.sightType1,
  AppStrings.sightType2,
  AppStrings.sightType3,
  AppStrings.sightType4,
  AppStrings.sightType5,
  AppStrings.sightType6,
  AppStrings.sightType7,
];

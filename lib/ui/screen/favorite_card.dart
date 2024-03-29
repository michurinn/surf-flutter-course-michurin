// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:provider/provider.dart';

// Карточка для Хочу посетить в Избранном
class FavoriteSight extends StatelessWidget {
  const FavoriteSight(
      {Key? key,
      required this.sight,
      required this.isFinished,
      this.onClosePressed})
      : super(key: key);
  final Place sight;
  final bool isFinished;
  final VoidCallback? onClosePressed;
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<SettingsInteractor>().appTheme;
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: Image.network(
                            sight.urls[0],
                            fit: BoxFit.fitWidth,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ).image),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Row(
                      children: [
                        isFinished
                            ? IconButton(
                                padding: const EdgeInsets.all(0),
                                iconSize: 22,
                                icon: Icon(Icons.share,
                                    color: themeProvider.iconColor),
                                onPressed: () {
                                  print("Share on card pressed");
                                },
                              )
                            : IconButton(
                                padding: const EdgeInsets.all(0),
                                iconSize: 22,
                                icon: SvgPicture.asset(AppAssets.calendar,
                                    color: themeProvider.iconColor),
                                onPressed: () async {
                                  DateTime? date = Platform.isAndroid
                                      ? await showDatePicker(
                                          confirmText: 'Запланировать',
                                          cancelText: 'Позже',
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 365),
                                          ),
                                        )
                                      : await showCupertinoDialog(
                                          context: context,
                                          builder: (context) =>
                                              const _CupertinoDatePickerBody(),
                                        );
                                  //На данном етапе просто выведем на екран дату
                                  print(date);
                                },
                              ),
                        IconButton(
                            iconSize: 22,
                            padding: const EdgeInsets.all(0),
                            icon: Icon(Icons.close,
                                color: themeProvider.iconColor),
                            onPressed: onClosePressed)
                      ],
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Text(
                      sight.placeType.toString(),
                      style: AppTypography.smallBoldwhite,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(sight.name, style: AppTypography.simpleText),
                    SizedBox(
                      height: 28,
                      child: isFinished
                          ? const Text("Цель достигнута на 12 окт. 2020",
                              style: AppTypography.small,
                              textAlign: TextAlign.start)
                          : const Text("Запланировано на 12 окт. 2020",
                              style: AppTypography.smallGreen,
                              textAlign: TextAlign.start),
                    ),
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

class _CupertinoDatePickerBody extends StatelessWidget {
  const _CupertinoDatePickerBody();

  @override
  Widget build(BuildContext context) {
    DateTime plannedDate = DateTime.now().add(const Duration(days: 1));
    final themeProvider = context.watch<SettingsInteractor>().appTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Container(
          decoration: BoxDecoration(
            color: themeProvider.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          width: MediaQuery.of(context).size.width,
          height: 350,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: CupertinoDatePicker(
                  initialDateTime: plannedDate,
                  minimumDate: DateTime.now(),
                  mode: CupertinoDatePickerMode.dateAndTime,
                  onDateTimeChanged: (DateTime value) {
                    plannedDate = value;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(plannedDate);
                    },
                    child: Text(
                      AppStrings.addToCalendar,
                      style: AppTypography.button
                          .copyWith(color: themeProvider.filterButtonColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppStrings.cancel,
                      style: AppTypography.button
                          .copyWith(color: themeProvider.filterButtonColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

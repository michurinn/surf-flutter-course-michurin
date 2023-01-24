import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_typography.dart';

// Карточка для Хочу посетить в Избранном
class FavoriteSight extends StatelessWidget {
  const FavoriteSight({Key? key, required this.sight, required this.isFinished})
      : super(key: key);
  final Sight sight;
  final bool isFinished;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          borderOnForeground: true,
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
                              sight.imagePath,
                              fit: BoxFit.fitWidth,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ).image),
                      ),
                    ),
                    Positioned(
                      right: 18,
                      top: 19,
                      child: SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            isFinished
                                ? Icon(Icons.share,
                                    color: themeProvider.appTheme.iconColor)
                                : SvgPicture.asset(AppAssets.calendar,
                                    color: themeProvider.appTheme.iconColor),
                            const SizedBox(width: 20),
                            Icon(Icons.close,
                                color: themeProvider.appTheme.iconColor)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Text(
                        sight.type,
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
                      Text(sight.details, style: AppTypography.small),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

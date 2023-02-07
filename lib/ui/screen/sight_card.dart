// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_typography.dart';

// Карточка для показа места
class SightCard extends StatelessWidget {
  const SightCard({Key? key, required this.sight}) : super(key: key);

  final Sight sight;
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
                    Ink(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: Image.network(
                              sight.imagePath,
                              fit: BoxFit.fitWidth,
                              loadingBuilder: (
                                BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress,
                              ) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 6.0,
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
                      child: InkWell(onTap: () => print("InkTapped")),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        iconSize: 20.0,
                        icon: SvgPicture.asset(
                          AppAssets.heart,
                          color: themeProvider.appTheme.iconColor,
                        ),
                        onPressed: () {
                          print("Icon-heart on card pressed");
                        },
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
                child: InkWell(
                  onTap: () {
                    print("Ink tapped");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          sight.name,
                          style: AppTypography.simpleText,
                        ),
                        const SizedBox.shrink(),
                        Text(
                          sight.details,
                          style: AppTypography.small,
                        ),
                      ],
                    ),
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

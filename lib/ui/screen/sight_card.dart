import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_typography.dart';

// Карточка для показа места
class SightCard extends StatelessWidget {
  const SightCard({Key? key, required this.sight, this.onTap})
      : super(key: key);
  final VoidCallback? onTap;
  final Place sight;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: width, maxHeight: width / 1.5, minHeight: width / 1.5),
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
                              sight.urls[0],
                              fit: BoxFit.fitWidth,
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                if (wasSynchronouslyLoaded) return child;
                                return CircularProgressIndicator(
                                  strokeWidth: 6.0,
                                  value: frame == null ? 0 : frame.toDouble(),
                                );
                              },
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
                      child: InkWell(onTap: onTap),
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
                        onPressed: () {},
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
                child: InkWell(
                  onTap: onTap,
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

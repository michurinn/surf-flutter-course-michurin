import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_typography.dart';

// Карточка для показа места
class SightCard extends StatefulWidget {
  const SightCard(
      {Key? key,
      required this.sight,
      this.onTap,
      this.onHeartTap,
      required this.isFavorite})
      : super(key: key);
  final VoidCallback? onTap;
  final VoidCallback? onHeartTap;
  final bool isFavorite;
  final Place sight;

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  late bool isFavorite;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(covariant SightCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    isFavorite = widget.isFavorite;
  }

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
                              widget.sight.urls[0],
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
                              errorBuilder: (context, error, stackTrace) {
                                print("Error is here)) $error");
                                return Center(
                                child: Container(width: 100,height: 120,color: Colors.amber,)
                              );
                              },
                            ).image),
                      ),
                      child: InkWell(onTap: widget.onTap),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: IconButton(
                        iconSize: 20.0,
                        icon: SvgPicture.asset(
                          isFavorite ? AppAssets.likeFilled : AppAssets.like,
                          color: themeProvider.appTheme.iconColor,
                        ),
                        onPressed: () => {
                          widget.onHeartTap!(),
                          setState(() {
                            isFavorite = !isFavorite;
                          })
                        },
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Text(
                        widget.sight.placeType.toString(),
                        style: AppTypography.smallBoldwhite,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: widget.onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.sight.name,
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

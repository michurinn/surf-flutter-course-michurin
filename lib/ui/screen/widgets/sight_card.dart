import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_typography.dart';
import 'package:provider/provider.dart';

// Карточка для показа места
class SightCard extends StatefulWidget {
  const SightCard(
      {Key? key,
      required this.sight,
      required this.onTap,
      required this.onHeartTap,
      required this.isFavorite})
      : super(key: key);
  final VoidCallback onTap;
  final VoidCallback onHeartTap;
  final bool isFavorite;
  final Place sight;

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  // Последний елемент потока хранит
  // переменная currentStateOfHeartButton, в неё записывается последний елемент
  // через подписку favoriteSubscription
  // При нажатии на кнопку-сердечко в поток отправляется значение,
  // обратное последнему
  late StreamController<bool> isFavoriteController;
  @override
  void initState() {
    super.initState();

    isFavoriteController = StreamController.broadcast();
    isFavoriteController.add(widget.isFavorite);
  }

  @override
  void dispose() {
    isFavoriteController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final themeProvider = context.watch<SettingsInteractor>().appTheme;
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
                              //Пока покажем заглушку
                              'https://www.mdpi.com/humans/humans-02-00017/article_deploy/html/images/humans-02-00017-g002.png',
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
                                return Center(
                                    child: Container(
                                  width: 100,
                                  height: 120,
                                  color: Colors.amber,
                                ));
                              },
                            ).image),
                      ),
                      child: InkWell(onTap: widget.onTap),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: StreamBuilder<bool>(
                          stream: isFavoriteController.stream,
                          initialData: widget.isFavorite,
                          builder: (context, snapshot) {
                            return IconButton(
                                iconSize: 20.0,
                                icon: SvgPicture.asset(
                                  snapshot.data == true
                                      ? AppAssets.likeFilled
                                      : AppAssets.like,
                                  color: themeProvider.iconColor,
                                ),
                                onPressed: () {
                                  widget.onHeartTap();
                                  if (snapshot.hasData) {
                                    isFavoriteController.add(!snapshot.data!);
                                  }
                                });
                          }),
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

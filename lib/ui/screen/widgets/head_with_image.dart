import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_assets.dart';

// Картинка места и кнопка Назад для sight_details
class HeadWithImage extends StatelessWidget {
  const HeadWithImage({
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
          child: Container(
            width: 32,
            height: 32,
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 11, horizontal: 13.5),
              child: SvgPicture.asset(AppAssets.back),
            ),
          ),
        ),
      ],
    );
  }
}
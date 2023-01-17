import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_typography.dart';

class SightDetails extends StatelessWidget {
  const SightDetails({Key? key, required this.sight}) : super(key: key);
  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _HeadWithImage(sight: sight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                _BodyWithTexts(sight: sight),
                const SizedBox(
                  height: 24,
                ),
                const _BottomWithButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Картинка места и кнопка Назад для sight_details
class _HeadWithImage extends StatelessWidget {
  const _HeadWithImage({
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
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 11, horizontal: 13.5),
              child: SvgPicture.asset(
                AppAssets.back,
                color: Theme.of(context).primaryColor,
                width: 5,
                height: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Тексты Название места и пр. для sight_details
class _BodyWithTexts extends StatelessWidget {
  const _BodyWithTexts({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(sight.name, style: AppTypography.title)),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(sight.type, style: AppTypography.smallBoldBlue),
            const SizedBox(
              width: 16,
            ),
            Text(
              sight.workTime,
              style: AppTypography.small,
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(sight.details, style: AppTypography.smallBlueDeep)),
      ],
    );
  }
}

// Кнопки Построить маршрут,запланировать, В избранное для sight_details
class _BottomWithButtons extends StatelessWidget {
  const _BottomWithButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 67, top: 13, bottom: 13),
          width: double.infinity,
          height: 48,
          color: Colors.lime,
          child: SvgPicture.asset(
            AppAssets.route,
            height: 20,
            width: 20,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const Divider(
          thickness: 2,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 10.5, left: 17, bottom: 10.5),
                alignment: Alignment.centerLeft,
                height: 40,
                color: Colors.lightGreen,
                child: SvgPicture.asset(
                  AppAssets.calendar,
                  width: 22,
                  height: 19,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(top: 10.5, left: 26, bottom: 10.5),
                alignment: Alignment.centerLeft,
                height: 40,
                color: const Color.fromARGB(255, 167, 24, 67),
                child: SvgPicture.asset(
                  AppAssets.heart,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

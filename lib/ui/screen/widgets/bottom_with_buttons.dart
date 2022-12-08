import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
// Кнопки Построить маршрут,запланировать, В избранное для sight_details
class BottomWithButtons extends StatelessWidget {
  const BottomWithButtons({
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
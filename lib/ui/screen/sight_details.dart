import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/AppTypography.dart';
import 'package:places/res/AppStrings.dart';

class SideDetails extends StatelessWidget {
  const SideDetails({Key? key, required this.sight}) : super(key: key);
  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            SizedBox(
              height: 360,
              child: Image.asset(sight.imagePath, fit: BoxFit.fitHeight),
            ),
            Positioned(
              left: 16,
              top: 36,
              child: Container(
                width: 32,
                height: 32,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 11, bottom: 11, left: 13.5, right: 13.5),
                  child: SvgPicture.asset('assets/icons/back_arrow.svg'),
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
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
                    const Text(AppStrings.workTime, style: AppTypography.small),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(sight.details,
                        style: AppTypography.smallBlueDeep)),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 67, top: 13, bottom: 13),
                  width: double.infinity,
                  height: 48,
                  color: Colors.lime,
                  child: SvgPicture.asset(
                    'assets/icons/route.svg',
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
                        padding: const EdgeInsets.only(
                            top: 10.5, left: 17, bottom: 10.5),
                        alignment: Alignment.centerLeft,
                        height: 40,
                        color: Colors.lightGreen,
                        child: SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          width: 22,
                          height: 19,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 10.5, left: 26, bottom: 10.5),
                        alignment: Alignment.centerLeft,
                        height: 40,
                        color: const Color.fromARGB(255, 167, 24, 67),
                        child: SvgPicture.asset(
                          'assets/icons/like.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

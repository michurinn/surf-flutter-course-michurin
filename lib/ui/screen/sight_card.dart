import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import '/res/AppTypography.dart';

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
                )),
                borderOnForeground: true,
                child: Column(children: [
                  Expanded(
                      child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage(sight.imagePath)),
                      ),
                    ), // BorderRadius пока не виден
                    Positioned(
                        right: 18,
                        top: 19,
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: SvgPicture.asset(
                            'assets/icons/like.svg',
                            color: Colors.white,
                          ),
                        )),
                    Positioned(
                        left: 16,
                        top: 16,
                        child: Text(
                          sight.type,
                          style: AppTypography.smallBoldwhite,
                        ))
                  ])),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(sight.name,
                                    style: AppTypography.simpleText),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(sight.details, style: AppTypography.small)
                              ])))
                ]))));
  }
}

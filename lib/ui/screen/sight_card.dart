import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import '/res/AppTypography.dart';

class SightCard extends StatelessWidget {
  const SightCard({Key? key, required this.sight}) : super(key: key);

  final Sight sight;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        height: 188,
        child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            borderOnForeground: false,
            child: Column(children: [
              Expanded(
                  child: Stack(children: [
                Container(
                  color: const Color.fromARGB(255, 197, 23, 159),
                ), // BorderRadius пока не виден
                Positioned(
                    right: 18,
                    top: 19,
                    child: Container(
                      color: Colors.deepOrange,
                      width: 20,
                      height: 20,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text(sight.name, style: AppTypography.simpleText),
                            const SizedBox(
                              height: 4,
                              width: double.infinity,
                            ),
                            Text(sight.details, style: AppTypography.small)
                          ])))
            ])));
  }
}

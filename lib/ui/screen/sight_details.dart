import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/AppTypography.dart';

class SideDetails extends StatelessWidget {
  const SideDetails({Key? key, required this.sight}) : super(key: key);
  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              width: double.infinity,
              height: 360,
              color: Colors.amber,
            ),
            Positioned(
              left: 16,
              top: 36,
              child: Container(
                width: 32,
                height: 32,
                color: Colors.teal,
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
                    const Text("режим работы", style: AppTypography.small),
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
                  width: double.infinity,
                  height: 48,
                  color: Colors.lime,
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
                        height: 40,
                        color: Colors.lightGreen,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        color: const Color.fromARGB(255, 167, 24, 67),
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

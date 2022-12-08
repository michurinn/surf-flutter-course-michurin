import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/widgets/body_with_texts.dart';
import 'package:places/ui/screen/widgets/bottom_with_buttons.dart';
import 'package:places/ui/screen/widgets/head_with_image.dart';

class SightDetails extends StatelessWidget {
  const SightDetails({Key? key, required this.sight}) : super(key: key);
  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeadWithImage(sight: sight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                BodyWithTexts(sight: sight),
                const SizedBox(
                  height: 24,
                ),
                const BottomWithButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

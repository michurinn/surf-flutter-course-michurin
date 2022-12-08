import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_typography.dart';
// Тексты Название места и пр. для sight_details
class BodyWithTexts extends StatelessWidget {
  const BodyWithTexts({
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
            Text(sight.workTime),
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
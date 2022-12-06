import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/AppColors.dart';
import 'package:places/res/AppTypography.dart';

import 'sight_card.dart';

// Карточка для Хочу посетить в Избранном
class FinishedSight extends SightCard {
  const FinishedSight({super.key, required this.sight}) : super(sight: sight);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Widget getLeading() {
    return SizedBox(
      height: 20,
      child: Row(
        children: const [
          Icon(Icons.share, color: AppColors.white),
          SizedBox(width: 20),
          Icon(Icons.close, color: AppColors.white)
        ],
      ),
    );
  }

  @override
  Widget getPlannedText() {
    return const SizedBox(
        height: 28,
        child: Text("Цель достигнута на 12 окт. 2020",
            style: AppTypography.small, textAlign: TextAlign.start));
  }

  @override
  MainAxisAlignment get getSpacesBehavior => MainAxisAlignment.spaceEvenly;
}

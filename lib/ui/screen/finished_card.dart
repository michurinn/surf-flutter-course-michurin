import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_typography.dart';

import 'sight_card.dart';

// Карточка для Хочу посетить в Избранном
class FinishedSight extends SightCard {
  const FinishedSight({super.key, required sight}) : super(sight: sight);


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

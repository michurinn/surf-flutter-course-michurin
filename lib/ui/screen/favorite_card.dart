import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/sight_card.dart';

// Карточка для Хочу посетить в Избранном
class FavoriteSight extends SightCard {
  const FavoriteSight({super.key, required sight}) : super(sight: sight);


  @override
  Widget getLeading() {
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.calendar, color: AppColors.white),
          const SizedBox(width: 20),
          const Icon(Icons.close, color: AppColors.white)
        ],
      ),
    );
  }

  @override
  Widget getPlannedText() {
    return const SizedBox(
        height: 28,
        child: Text("Запланировано на 12 окт. 2020",
            style: AppTypography.smallGreen, textAlign: TextAlign.start));
  }

  @override
  MainAxisAlignment get getSpacesBehavior => MainAxisAlignment.spaceEvenly;
}

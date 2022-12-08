// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
// ТабБАр приложения
TabBar AppTabBar() {
  return const TabBar(
      indicator: BoxDecoration(
          color: AppColors.whiteSecondary,
          borderRadius: BorderRadius.all(Radius.circular(40.0))),
      unselectedLabelColor: AppColors.whiteSecondary2,
      unselectedLabelStyle: AppTypography.smallBoldwhite,
      labelStyle: AppTypography.smallBoldwhite,
      labelColor: AppColors.white,
      labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      tabs: [Text(AppStrings.wouldLikeToVisit), Text(AppStrings.justVisited)]);
}

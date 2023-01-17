import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  static const subtitle = TextStyle(
      fontSize: 18.0,
      fontFamily: "Roboto",
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: AppColors.whiteMain);
  static const largeTitle = TextStyle(
      fontSize: 32.0,
      fontFamily: "Roboto",
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: AppColors.whiteSecondary);
  static const title = TextStyle(
      fontSize: 24.0,
      fontFamily: "Roboto",
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: AppColors.whiteSecondary);
  static const smallBoldwhite = TextStyle(
    fontSize: 14.0,
    fontFamily: "Roboto",
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: .5,
    wordSpacing: 2,
    fontStyle: FontStyle.normal,
    color: AppColors.white,
  );
  static const smallBoldBlue = TextStyle(
    fontSize: 14.0,
    fontFamily: "Roboto",
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: .5,
    fontStyle: FontStyle.normal,
    color: AppColors.whiteSecondary,
  );
  static const smallBlue = TextStyle(
    fontSize: 14.0,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w400,
    letterSpacing: .5,
    fontStyle: FontStyle.normal,
    color: AppColors.whiteSecondary2,
  );
  static const smallBlueDeep = TextStyle(
    fontSize: 14.0,
    fontFamily: "Roboto",
    height: 1.25,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: AppColors.whiteSecondary,
  );
  static const simpleText = TextStyle(
    fontSize: 16.0,
    fontFamily: "Roboto",
    height: 1.25,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    color: AppColors.whiteSecondary,
  );
  static const small = TextStyle(
    fontSize: 14.0,
    fontFamily: "Roboto",
    height: 1.25,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: AppColors.whiteSecondary2,
  );
  static const smallGreen = TextStyle(
    fontSize: 14.0,
    fontFamily: "Roboto",
    height: 1.25,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: AppColors.whiteGreen,
  );
}

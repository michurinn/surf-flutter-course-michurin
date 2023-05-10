import 'package:flutter/material.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100.0),
      child: Column(
        children: [
          Icon(
            Icons.cancel_outlined,
            size: 64,
            color: color,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 24.0),
            child: Text(
              AppStrings.error,
              textAlign: TextAlign.center,
              style: AppTypography.subtitle.copyWith(color: color),
            ),
          ),
          Text(
            AppStrings.errorDescription,textAlign: TextAlign.center,
            style: AppTypography.small.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/shared/colors.dart';

abstract class AppTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: 'Fira',
        primaryColor: AppColors.primary);
  }
}

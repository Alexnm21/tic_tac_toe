import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData themeData = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.boxColor,
      elevation: 1.5,
      titleTextStyle: TextStyle(
        color: AppColors.textLight,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textLight),
      bodyMedium: TextStyle(color: AppColors.textLight),
      bodySmall: TextStyle(color: AppColors.textLight),
    ),
    
  );
}
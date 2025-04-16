import 'package:flutter/material.dart';
import 'package:notes/theme/colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    error: AppColors.error,
  ),
);

import 'package:altlink/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static theme({bool isDark = false}) => ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        useMaterial3: true,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: isDark ? AppColors.bgDark : null,
        colorScheme: const ColorScheme.dark().copyWith(
          background: AppColors.bgDark,
          primary: AppColors.primary,
          //   // onPrimary: switch thumb,
          primaryContainer: AppColors.primary,
          onPrimaryContainer: AppColors.text,
          secondary: AppColors.primary,
          surface: AppColors.surfaceDark,
        ),
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: isDark ? AppColors.bgDark : null,
          foregroundColor: AppColors.text,
          iconTheme: const IconThemeData(color: AppColors.text),
        ),
      );
}

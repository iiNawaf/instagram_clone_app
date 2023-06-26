import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: AppColors.bgColor,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.bgColor,
      iconTheme: IconThemeData(color: AppColors.primaryTextColor, size: AppDimensions.iconLarge),
    ),
    iconTheme: const IconThemeData(color: AppColors.primaryTextColor, size: AppDimensions.iconLarge),
    textTheme: const TextTheme(
      // Title
      titleSmall: TextStyle(color: AppColors.primaryTextColor),
      titleMedium: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: AppDimensions.fontLarge,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: AppDimensions.fontExtraLarge,
          fontWeight: FontWeight.bold),

      // Label
      labelSmall: TextStyle(color: AppColors.primaryColor, fontSize: AppDimensions.fontSmall),
      labelMedium: TextStyle(
          color: AppColors.primaryColor,
          fontSize: AppDimensions.fontMedium,
          fontWeight: FontWeight.bold),

      // Body
      bodySmall: TextStyle(color: AppColors.secondaryTextColor, fontSize: AppDimensions.fontExtraSmall),
      bodyMedium: TextStyle(color: AppColors.primaryTextColor, fontSize: AppDimensions.fontSmall),

      headlineSmall: TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: AppDimensions.fontSmall,
          fontWeight: FontWeight.bold),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
    ),

    // TextField style
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppDimensions.paddingMedium),
      hintStyle: TextStyle(
          color: AppColors.secondaryTextColor,
          fontSize: AppDimensions.fontSmall,
          fontWeight: FontWeight.normal),
      border: InputBorder.none,
    ),
  );

  static ThemeData lightTheme = ThemeData(
      // App light theme (not supported currently)
      );
}

import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class CustomSnackbar{
  static SnackBar customSnackbar(context, Icon icon, String title){
  return SnackBar(
    showCloseIcon: false,
    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      duration: const Duration(seconds: 1),
        elevation: 6.0,
        backgroundColor: AppColors.snackBarBgColor,
        behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusMedium)),
      content: Row(
        children: [
          icon,
          Text(title, style: Theme.of(context).textTheme.bodyMedium,),
        ],
      )
    );
}
}

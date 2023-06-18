import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class ProfileButton extends StatelessWidget {
  String title;
  Function() onTap;
  ProfileButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        decoration: BoxDecoration(
            color: AppColors.buttonBgColor, borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall)),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}

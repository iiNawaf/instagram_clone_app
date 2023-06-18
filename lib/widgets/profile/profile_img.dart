import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class ProfileImg extends StatelessWidget {
  String img;
  ProfileImg({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Stack(
        children: [
          Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: AppColors.primaryTextColor,
                  borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge)),
              child: Image.asset('./assets/default_profile.png')),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.bgColor)),
                child: const Icon(
                  Icons.add,
                  color: AppColors.primaryTextColor,
                  size: AppDimensions.iconSmall,
                ),
              ))
        ],
      ),
    );
  }
}

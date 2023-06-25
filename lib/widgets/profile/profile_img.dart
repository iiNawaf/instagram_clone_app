import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/constants.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class ProfileImg extends StatelessWidget {
  final String imgUrl;
  const ProfileImg({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: AppColors.containerBgColor,
              borderRadius:
                  BorderRadius.circular(AppDimensions.borderRadiusLarge)),
          child: imgUrl == "" 
          ? Image.asset(Constants.defaultImage)
          : FittedBox(
            fit: BoxFit.fill,
            child: Image.network(imgUrl),
          )),
    );
  }
}

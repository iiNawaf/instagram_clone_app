import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class PostOwnerImg extends StatelessWidget {
  final String imgUrl;
  const PostOwnerImg({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: AppColors.containerBgColor,
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusLarge)),
        child: Image.network(
          imgUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

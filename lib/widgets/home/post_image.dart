import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class PostImage extends StatelessWidget {
  final String imgUrl;
  const PostImage({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginValue),
      height: 300,
      color: AppColors.containerBgColor,
      child: Image.network(
        imgUrl,
        fit: BoxFit.fill,
      ),
    );
  }
}

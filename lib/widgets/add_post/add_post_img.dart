import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';

class AddPostImg extends StatelessWidget {
  final File? pickedImage;
  const AddPostImg({super.key, required this.pickedImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      color: AppColors.containerBgColor,
      child: pickedImage != null 
      ? Image.file(pickedImage!, fit: BoxFit.fill,) : const Icon(Icons.image_outlined),
    );
  }
}

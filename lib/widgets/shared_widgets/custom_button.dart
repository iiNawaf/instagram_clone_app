import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class CustomButton extends StatelessWidget {
  String title;
  Function() click;
  Color? bgColor;
  double? opacity;
  bool isLoading;
  CustomButton(
      {super.key,
      required this.title,
      required this.click,
      this.bgColor,
      this.opacity,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity ?? 1,
      child: GestureDetector(
        onTap: click,
        child: Container(
          height: AppDimensions.containerHeightSmall,
          decoration: BoxDecoration(
              color: bgColor ?? AppColors.primaryColor,
              borderRadius:
                  BorderRadius.circular(AppDimensions.borderRadiusMedium)),
          child: Center(
            child: isLoading
            ? const CupertinoActivityIndicator()
            : Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );
  }
}

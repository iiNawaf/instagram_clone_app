import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class CustomTextField extends HookWidget {
  String hintText;
  Widget? suffixIcon;
  bool obscureText;
  bool isError;
  TextEditingController controller;
  CustomTextField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    required this.isError,
    required this.obscureText,
    required this.controller,
  });

  final showSuffix = useState(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.containerHeightSmall,
      decoration: BoxDecoration(
          color: AppColors.inputBgColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          border: Border.all(color: isError? AppColors.errorColor : AppColors.borderColor)),
      child: Center(
        child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: showSuffix.value ? suffixIcon : null),
            onChanged: (value) {
              if (value.isNotEmpty) {
                showSuffix.value = true;
              } else {
                showSuffix.value = false;
              }
            }),
      ),
    );
  }
}

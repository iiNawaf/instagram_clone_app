import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class CustomTextField extends HookWidget {
  final String hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool isError;
  final String type;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  CustomTextField(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      required this.isError,
      required this.obscureText,
      required this.controller,
      required this.type,
      this.keyboardType,
      this.maxLines
      });

  final showSuffix = useState(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.containerHeightSmall,
      decoration: _buildBoxDecoration(),
      child: Center(
        child: TextField(
          maxLines: maxLines ?? 1,
          keyboardType: keyboardType,
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

  _buildBoxDecoration() {
    return type == "auth"
        ? BoxDecoration(
            color: AppColors.inputBgColor,
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusMedium),
            border: Border.all(
                color: isError ? AppColors.errorColor : AppColors.borderColor))
        : null;
  }
  
}

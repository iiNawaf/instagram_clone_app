import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hintText;
  Widget? suffixIcon;
  bool obscureText;
  CustomTextField({
    super.key, 
    required this.hintText, 
    this.suffixIcon,
    required this.obscureText
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration:
          InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
    );
  }
}

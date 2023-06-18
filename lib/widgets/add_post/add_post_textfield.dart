import 'package:flutter/material.dart';

class AddPostTextField extends StatelessWidget {
  const AddPostTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        hintText: "Write a caption...",
      ),
    );
  }
}

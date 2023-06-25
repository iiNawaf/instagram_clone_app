import 'package:flutter/material.dart';

class PostLikeBtn extends StatelessWidget {
  final Function() btnAction;
  const PostLikeBtn({super.key, required this.btnAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnAction,
      child: const Icon(Icons.favorite_border),
    );
  }
}

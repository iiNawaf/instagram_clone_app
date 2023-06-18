import 'package:flutter/material.dart';

class PostLikeBtn extends StatelessWidget {
  Function() btnAction;
  PostLikeBtn({super.key, required this.btnAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnAction,
      child: const Icon(Icons.favorite_border),
    );
  }
}

import 'package:flutter/material.dart';

class PostLikesNumber extends StatelessWidget {
  int number;
  PostLikesNumber({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${number.toString()} Likes",
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

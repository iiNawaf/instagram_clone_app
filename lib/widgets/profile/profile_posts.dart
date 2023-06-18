import 'package:flutter/material.dart';

class ProfilePosts extends StatelessWidget {
  int posts;
  ProfilePosts({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Text(
      posts.toString(),
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

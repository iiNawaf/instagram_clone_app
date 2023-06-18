import 'package:flutter/material.dart';

class ProfileFollowers extends StatelessWidget {
  int followers;
  ProfileFollowers({super.key, required this.followers});

  @override
  Widget build(BuildContext context) {
    return Text(
      followers.toString(),
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

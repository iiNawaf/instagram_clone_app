import 'package:flutter/material.dart';

class ProfileFollowers extends StatelessWidget {
  final int followers;
  const ProfileFollowers({super.key, required this.followers});

  @override
  Widget build(BuildContext context) {
    return Text(
      followers.toString(),
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

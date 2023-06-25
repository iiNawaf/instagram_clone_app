import 'package:flutter/material.dart';

class ProfileFollowing extends StatelessWidget {
  final int following;
  const ProfileFollowing({super.key, required this.following});

  @override
  Widget build(BuildContext context) {
    return Text(
      following.toString(),
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

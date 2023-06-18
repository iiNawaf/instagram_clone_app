import 'package:flutter/material.dart';

class ProfileUsername extends StatelessWidget {
  String username;
  ProfileUsername({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

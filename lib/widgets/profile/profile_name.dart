import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  String name;
  ProfileName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

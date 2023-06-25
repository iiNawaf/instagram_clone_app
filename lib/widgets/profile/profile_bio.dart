import 'package:flutter/material.dart';

class ProfileBio extends StatelessWidget {
  final String bio;
  const ProfileBio({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Text(bio);
  }
}

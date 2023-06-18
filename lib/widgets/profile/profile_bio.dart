import 'package:flutter/material.dart';

class ProfileBio extends StatelessWidget {
  String bio;
  ProfileBio({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return Text(bio);
  }
}

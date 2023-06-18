import 'package:flutter/material.dart';

class PostOwnerUsername extends StatelessWidget {
  String username;
  PostOwnerUsername({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Text(username);
  }
}

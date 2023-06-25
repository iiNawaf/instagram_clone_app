import 'package:flutter/material.dart';

class PostOwnerUsername extends StatelessWidget {
  final String username;
  const PostOwnerUsername({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Text(username);
  }
}

import 'package:flutter/material.dart';

class PostCaption extends StatelessWidget {
  final String username;
  final String caption;
  const PostCaption({super.key, required this.caption, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$username ", style: Theme.of(context).textTheme.headlineSmall),
        Text(
          caption,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class AddPostTag extends StatelessWidget {
  const AddPostTag({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text("Tag People", style: Theme.of(context).textTheme.labelLarge,),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}

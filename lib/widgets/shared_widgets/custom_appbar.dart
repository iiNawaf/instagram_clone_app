import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class CustomAppBar extends StatelessWidget {
  Widget? leading;
  List<Widget> actions;
  String? title;
  CustomAppBar({super.key, this.leading, required this.actions, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
              title ?? "",
              style: Theme.of(context).textTheme.titleMedium
            ),
      leading: leading == null ? null : Padding(
        padding: const EdgeInsets.only(left: AppDimensions.paddingMedium),
        child: leading
      ),
      leadingWidth: leading == null ? 56 : 120,
      actions: actions,
    );
  }
}

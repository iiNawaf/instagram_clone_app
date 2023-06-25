import 'package:flutter/material.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final String? title;
  final double? leadingWidth;
  const CustomAppBar({super.key, this.leading, this.actions, this.title, this.leadingWidth});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? "", style: Theme.of(context).textTheme.titleMedium),
      leading: leading == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: AppDimensions.paddingMedium),
              child: leading),
      leadingWidth: leadingWidth ?? 56.0,
      actions: actions ?? [],
    );
  }
}

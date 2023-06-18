import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/viewmodels/add_post_viewmodel.dart';
import 'package:instagram_clone_app/widgets/add_post/add_post_img.dart';
import 'package:instagram_clone_app/widgets/add_post/add_post_tag.dart';
import 'package:instagram_clone_app/widgets/add_post/add_post_textfield.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_appbar.dart';

final addPostViewModel = ChangeNotifierProvider((ref) {
  return AddPostViewModel();
});

class AddPostView extends ConsumerWidget {
  const AddPostView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(addPostViewModel);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppDimensions.appBarHeight),
        child: CustomAppBar(title: viewModelProvider.appBarTitle, actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: AppDimensions.paddingMedium),
              child: Text(
                "Share",
                style: Theme.of(context).textTheme.labelMedium
              ),
            ),
          )
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                      height: 90,
                      color: Colors.blue,
                      child: AddPostImg(),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                      height: 90,
                      color: Colors.red,
                      child: AddPostTextField(),
                    ),
                  ),
                ],
              ),
              const Divider(color: AppColors.borderColor),
              AddPostTag()
            ],
          ),
        ),
      ),
    );
  }
}

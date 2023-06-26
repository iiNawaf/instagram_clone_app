import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/resources/constants/routes/routes.dart';
import 'package:instagram_clone_app/viewmodels/add_post/add_post_viewmodel.dart';
import 'package:instagram_clone_app/widgets/add_post/add_post_img.dart';
import 'package:instagram_clone_app/widgets/add_post/add_post_tag.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_appbar.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_textfield.dart';

final addPostViewModelProvider = ChangeNotifierProvider((ref) {
  return AddPostViewModel(ref);
});

class AddPostView extends HookConsumerWidget {
  const AddPostView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(addPostViewModelProvider);
    viewModel.captionController = useTextEditingController();
    viewModel.image = useState(null);
    viewModel.isLoading = useState(false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppDimensions.appBarHeight),
        child: CustomAppBar(title: viewModel.appBarTitle, actions: [
          viewModel.isLoading!.value!
              ? const CupertinoActivityIndicator()
              : GestureDetector(
                  onTap: () async {
                    viewModel.isLoading!.value = true;
                    if (viewModel.captionController!.text == "") {
                      viewModel.isLoading!.value = false;
                      viewModel.showSnackbar(context);
                      return;
                    } else if (viewModel.image!.value == null) {
                      viewModel.isLoading!.value = false;
                      viewModel.showSnackbar(context);
                      return;
                    } else {
                      await ref.read(addPostViewModelProvider).uploadPost();
                      viewModel.isLoading!.value = false;
                      context.pushNamed(AppRoutes.appManagerRouteName);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: AppDimensions.paddingMedium),
                    child: Text("Share",
                        style: Theme.of(context).textTheme.labelMedium),
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
                      child: GestureDetector(
                        onTap: () async {
                          viewModel.showBottomActionSheet(context);
                        },
                        child: AddPostImg(
                          pickedImage: viewModel.image!.value,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 90,
                      child: CustomTextField(
                        hintText: "Write a caption...",
                        isError: false,
                        obscureText: false,
                        controller: viewModel.captionController!,
                        type: "add_post",
                        maxLines: 4,
                      ),
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

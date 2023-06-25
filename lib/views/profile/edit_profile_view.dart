import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/constants.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/viewmodels/profile/edit_profile_viewmodel.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_appbar.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_textfield.dart';

final editProfileViewModelProvider = ChangeNotifierProvider((ref) {
  return EditProfileViewModel(ref);
});

class EditProfileView extends HookConsumerWidget {
  EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(editProfileViewModelProvider);
    final nameController = useTextEditingController();
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final bioController = useTextEditingController();
    final isLoading = useState(false);
    viewModel.image = useState(null);

    useEffect(() {
      if (viewModel.isInit) {
        nameController.text = viewModel.loggedInUser().name;
        usernameController.text = viewModel.loggedInUser().username;
        emailController.text = viewModel.loggedInUser().email;
        bioController.text = viewModel.loggedInUser().bio;
        viewModel.isInit = false;
      }

      return () {
        print("Disposed");
        viewModel.isInit = true;
      };
    }, [viewModel.isInit]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppDimensions.appBarHeight),
        child: CustomAppBar(
          title: "Edit profile",
          actions: [
            isLoading.value
                ? const CupertinoActivityIndicator()
                : GestureDetector(
                    onTap: () async {
                      isLoading.value = true;
                      final result = await ref
                          .read(editProfileViewModelProvider)
                          .updateUserProfile(
                              nameController.text,
                              usernameController.text.replaceAll(" ", ""),
                              emailController.text,
                              bioController.text);
                      if (!result) {
                        isLoading.value = false;
                        viewModel.showSnackbar(context);

                        return;
                      }
                      isLoading.value = false;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: AppDimensions.paddingMedium),
                      child: Text("Done",
                          style: Theme.of(context).textTheme.labelMedium),
                    ),
                  )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadiusLarge),
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: AppColors.containerBgColor,
                      borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusLarge)),
                  child: viewModel.image!.value == null &&
                          viewModel.loggedInUser().profileImageUrl == ""
                      ? Image.asset(Constants.defaultImage)
                      : viewModel.image!.value == null
                          ? Image.network(
                              viewModel.loggedInUser().profileImageUrl)
                          : Image.file(viewModel.image!.value!),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => viewModel.showBottomActionSheet(context),
              child: Text("Edit picture",
                  style: Theme.of(context).textTheme.labelMedium),
            ),
            const SizedBox(height: 10),
            const Divider(color: AppColors.borderColor),
            Container(
              padding: const EdgeInsets.only(
                  right: AppDimensions.paddingMedium,
                  left: AppDimensions.paddingMedium),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Name",
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  Expanded(
                      flex: 3,
                      child: CustomTextField(
                          type: "edit_profile",
                          hintText: "Enter name",
                          isError: false,
                          obscureText: false,
                          controller: nameController)),
                ],
              ),
            ),
            const Divider(color: AppColors.borderColor),
            Container(
              padding: const EdgeInsets.only(
                  right: AppDimensions.paddingMedium,
                  left: AppDimensions.paddingMedium),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Username",
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  Expanded(
                      flex: 3,
                      child: CustomTextField(
                          type: "edit_profile",
                          hintText: "Enter username",
                          isError: false,
                          obscureText: false,
                          controller: usernameController)),
                ],
              ),
            ),
            const Divider(color: AppColors.borderColor),
            Container(
              padding: const EdgeInsets.only(
                  right: AppDimensions.paddingMedium,
                  left: AppDimensions.paddingMedium),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Email",
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  Expanded(
                      flex: 3,
                      child: CustomTextField(
                          type: "edit_profile",
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Enter your email address",
                          isError: false,
                          obscureText: false,
                          controller: emailController)),
                ],
              ),
            ),
            const Divider(color: AppColors.borderColor),
            Container(
              padding: const EdgeInsets.only(
                  right: AppDimensions.paddingMedium,
                  left: AppDimensions.paddingMedium),
              child: Row(
                children: [
                  Expanded(
                    child: Text("Bio",
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  Expanded(
                      flex: 3,
                      child: CustomTextField(
                          type: "edit_profile",
                          hintText: "Enter a bio",
                          isError: false,
                          obscureText: false,
                          controller: bioController)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

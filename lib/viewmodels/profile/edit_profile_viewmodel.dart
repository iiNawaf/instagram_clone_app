import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';
import 'package:instagram_clone_app/resources/constants/icons/icons.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_select_image_sheet.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_snackbar.dart';

class EditProfileViewModel extends ChangeNotifier {
  ChangeNotifierProviderRef<Object?> ref;
  EditProfileViewModel(this.ref);

  bool isInit = true;
  ValueNotifier<File?>? image;

  UserModel loggedInUser() {
    return ref.read(userProvider).loggedInUser!;
  }

  Future<bool> updateUserProfile(
      String name, String username, String email, String bio) async {
    try {
      final user = ref.read(userProvider);
      bool isUsernameAlreadyExist = await user.isUsernameAlreadyExist(username);
      if (isUsernameAlreadyExist && username != user.loggedInUser!.username) {
        print("Username Used!");
        return false;
      }
      String? imageUrl = image!.value != null
          ? await user.getImageUrl(image!.value!)
          : loggedInUser().profileImageUrl;
      await user.updateUserProfile({
        'id': loggedInUser().id,
        'name': name,
        'username': username,
        'email': email,
        'bio': bio,
        'profileImageUrl': imageUrl
      });
      notifyListeners();
      return true;
    } catch (e) {
      print("Error updating: $e");
      return false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;

    final tempImage = File(pickedImage.path);
    image!.value = tempImage;
  }

  void showBottomActionSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return CustomSelectImageSheet(
            selectImageFromGallery: () {
              pickImage(ImageSource.gallery);
              context.pop();
            },
            selectImageFromCamera: () {
              pickImage(ImageSource.camera);
              context.pop();
            },
            imgUrl: loggedInUser().profileImageUrl,
          );
        });
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar.customSnackbar(
        context,
        Image.asset(AppIcons.exclamationMarkIcon),
        "This username isn't available. Please try another."));
  }
}

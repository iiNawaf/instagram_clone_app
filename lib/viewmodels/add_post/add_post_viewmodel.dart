import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/repositories/post_repository.dart';
import 'package:instagram_clone_app/resources/constants/icons/icons.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_select_image_sheet.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_snackbar.dart';

class AddPostViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef<Object?> ref;
  AddPostViewModel(this.ref);

  final appBarTitle = "New post";

  ValueNotifier<File?>? image;
  ValueNotifier<bool?>? isLoading;
  TextEditingController? captionController;

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;

    final tempImage = File(pickedImage.path);
    image!.value = tempImage;
  }

  Future<bool> uploadPost() async {
    try {
      ref.read(postProvider).uploadPost(image!.value!, captionController!.text);
      notifyListeners();
      return true;
    } catch (e) {
      print("FAILED SHIT: $e");
      return false;
    }
  }

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar.customSnackbar(
        context,
        Image.asset(AppIcons.exclamationMarkIcon),
        "Please make sure to fill all the inputs."));
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
            imgUrl: null,
          );
        });
  }
}

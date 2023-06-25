import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef<Object?> ref;
  ProfileViewModel(this.ref);

  UserModel loggedInUser() {
    return ref.watch(userProvider).loggedInUser!;
  }
}

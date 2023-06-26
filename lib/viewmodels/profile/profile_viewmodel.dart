import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/models/post/post_model.dart';
import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:instagram_clone_app/repositories/post_repository.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef<Object?> ref;
  ProfileViewModel(this.ref);

  ValueNotifier<bool>? isInit;
  ValueNotifier<bool>? isLoading;

  UserModel loggedInUser() {
    return ref.watch(userProvider).loggedInUser!;
  }

  List<PostModel> getUserPosts() {
    return ref.read(postProvider).userPosts;
  }

  Future<bool> fetchUserPosts() async {
    try {
      await ref.read(postProvider).fetchUserPost(loggedInUser().id);
      notifyListeners();
      return true;
    } catch (e) {
      print("User: $e");
      return false;
    }
  }
}

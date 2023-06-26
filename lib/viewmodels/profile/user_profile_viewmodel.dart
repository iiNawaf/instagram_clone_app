import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/models/post/post_model.dart';
import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:instagram_clone_app/repositories/post_repository.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';

class UserProfileViewModel extends ChangeNotifier {
  ChangeNotifierProviderRef<Object?> ref;
  UserProfileViewModel(this.ref);

  ValueNotifier<bool>? isInit;
  ValueNotifier<bool>? isLoading;
  UserModel? visitedUser;

  List<PostModel> getUserPosts() {
    return ref.read(postProvider).userPosts;
  }

  Future<void> fetchvisitedUser(String id) async {
    try {
      final user = await ref.read(userProvider).fetchRetrievedUser(id);
      visitedUser = UserModel(
          id: id,
          email: user['email'],
          name: user['name'],
          username: user['username'],
          profileImageUrl: user['profileImageUrl'],
          bio: user['bio']);
      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<bool> fetchvisitedUserPosts(String id) async {
    try {
      await ref.read(postProvider).fetchUserPost(id);
      notifyListeners();
      return true;
    } catch (e) {
      print("User: $e");
      return false;
    }
  }
}

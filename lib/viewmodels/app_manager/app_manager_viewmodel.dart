import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/models/post/post_model.dart';
import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:instagram_clone_app/repositories/post_repository.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';
import 'package:instagram_clone_app/views/home/home_view.dart';
import 'package:instagram_clone_app/views/profile/profile_view.dart';

class AppManagerViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef<Object?> ref;
  AppManagerViewModel(this.ref);

  UserModel loggedInUser() {
    return ref.read(userProvider).loggedInUser!;
  }

  List<UserModel> postsOwners = [];

  ValueNotifier<bool>? isInit;
  ValueNotifier<bool>? isLoading;

  // Define page index
  late ValueNotifier<int> selectedIndex;

  List<PostModel> allPosts() {
    return ref.read(postProvider).userPosts;
  }

  Future<void> fetchAllPosts() async {
    try {
      await ref.read(postProvider).fetchAllPosts();
      notifyListeners();
    } catch (e) {
      print("Error home: $e");
    }
  }

  Future<void> fetchAllPostsOwners() async {
    try {
      postsOwners = [];
      for (int i = 0; i < allPosts().length; i++) {
        final user = await ref
            .read(postProvider)
            .fetchPostOwnerData(allPosts()[i].userId);
        postsOwners.add(UserModel(
            id: user['id'],
            email: user['email'],
            name: user['name'],
            username: user['username'],
            profileImageUrl: user['profileImageUrl'],
            bio: user['bio']));
      }
      notifyListeners();
    } catch (e) {
      print("Error fetching: $e");
    }
  }

  // This method changes the page index
  void onItemTapped(int index) {
    if (index == 1) return;
    selectedIndex.value = index;
  }

  // BottomNavigationBar pages
  List<Widget> pages = <Widget>[
    const HomeView(),
    Container(),
    const ProfileView(),
  ];
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';
import 'package:instagram_clone_app/views/home/home_view.dart';
import 'package:instagram_clone_app/views/profile/profile_view.dart';

class AppManagerViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef<Object?> ref;
  AppManagerViewModel(this.ref);

  UserModel loggedInUser() {
    return ref.read(userProvider).loggedInUser!;
  }

  // Define page index
  late ValueNotifier<int> selectedIndex;

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

import 'package:flutter/material.dart';
import 'package:instagram_clone_app/views/home/home_view.dart';
import 'package:instagram_clone_app/views/profile/profile_view.dart';

class AppManagerViewModel extends ChangeNotifier {
  // Define page index
  late ValueNotifier<int> selectedIndex;

  // This method changes the page index
  void onItemTapped(int index) {
    if (index == 1) return;
    selectedIndex.value = index;
  }

  // BottomNavigationBar pages
  List<Widget> pages = <Widget>[
    HomeView(),
    Container(),
    ProfileView(),
  ];
}

import 'package:flutter/material.dart';
import 'package:instagram_clone_app/viewmodels/home_viewmodel.dart';
import 'package:instagram_clone_app/viewmodels/profile_viewmodel.dart';
import 'package:instagram_clone_app/views/home_view.dart';
import 'package:instagram_clone_app/views/profile_view.dart';

class AppManagerViewModel extends ChangeNotifier {
  // Define view models of views that are under App Manager.
  HomeViewModel homeViewModel = HomeViewModel();
  ProfileViewModel profileViewModel = ProfileViewModel();

  // Define page index
  late ValueNotifier<int> selectedIndex;

  // This method changes the page index
  void onItemTapped(int index) {
    if (index == 1) return;
    selectedIndex.value = index;
  }

  // BottomNavigationBar items icons
  final selectedHomeIcon = "././assets/home_selected.png";
  final unSelectedHomeIcon = "././assets/home_unselected.png";
  final selectedAddIcon = "././assets/add_selected.png";
  final unSelectedAddIcon = "././assets/add_unselected.png";
  final selectedProfileIcon = "././assets/profile_selected.png";
  final unSelectedProfileIcon = "././assets/profile_unselected.png";

  // BottomNavigationBar pages
  List<Widget> pages = <Widget>[
    HomeView(),
    Container(),
    ProfileView(),
  ];
}

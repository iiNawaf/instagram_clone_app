import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/constants.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/viewmodels/app_manager_viewmodel.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_appbar.dart';

final appManagerViewModel = ChangeNotifierProvider((ref) {
  return AppManagerViewModel();
});

class AppManagerView extends HookConsumerWidget {
  const AppManagerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(appManagerViewModel);
    viewModelProvider.selectedIndex = useState(0);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppDimensions.appBarHeight),
        child: CustomAppBar(
          leading: viewModelProvider.selectedIndex.value == 0 
          ? Image.asset(Constants.logoText, height: 45)
          : Padding(
            padding: const EdgeInsets.only(top: AppDimensions.paddingMedium),
            child: Text(viewModelProvider.profileViewModel.appBarTitle, style: Theme.of(context).textTheme.titleLarge),
          ),
          actions: [
          viewModelProvider.selectedIndex.value == 0 
          ? Padding(
            padding: const EdgeInsets.only(right: AppDimensions.paddingMedium),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.favorite_border),
                )
              ],
            ),
          ) : Container()
        ]),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.borderColor))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Image.asset(viewModelProvider.selectedIndex.value == 0
                        ? viewModelProvider.selectedHomeIcon
                        : viewModelProvider.unSelectedHomeIcon),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(),
                    label: 'New Post',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(viewModelProvider.selectedIndex.value == 2 
                    ? viewModelProvider.selectedProfileIcon 
                    : viewModelProvider.unSelectedProfileIcon),
                    label: 'Profile',
                  ),
                ],
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: viewModelProvider.selectedIndex.value,
                selectedItemColor: AppColors.primaryTextColor,
                backgroundColor: AppColors.bgColor,
                onTap: viewModelProvider.onItemTapped),
            Positioned(
              top: 14,
              child: GestureDetector(
                  onTap: () => context.go('/add_post'),
                  child: Image.asset(viewModelProvider.unSelectedAddIcon)),
            ),
          ],
        ),
      ),
      body: viewModelProvider.pages
          .elementAt(viewModelProvider.selectedIndex.value),
    );
  }
}

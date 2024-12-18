import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/constants.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/resources/constants/icons/icons.dart';
import 'package:instagram_clone_app/resources/constants/routes/routes.dart';
import 'package:instagram_clone_app/viewmodels/app_manager/app_manager_viewmodel.dart';
import 'package:instagram_clone_app/views/loading_view.dart';
import 'package:instagram_clone_app/widgets/shared_widgets/custom_appbar.dart';

final appManagerViewModelProvider = ChangeNotifierProvider((ref) {
  return AppManagerViewModel(ref);
});

class AppManagerView extends HookConsumerWidget {
  const AppManagerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(appManagerViewModelProvider);
    viewModel.selectedIndex = useState(0);
    viewModel.isInit = useState(true);
    viewModel.isLoading = useState(false);
    useEffect(() {
      if (viewModel.isInit!.value) {
        viewModel.isLoading!.value = true;
        Future.microtask(() async {
          await viewModel.fetchAllPosts();
          await viewModel.fetchAllPostsOwners();
          viewModel.isLoading!.value = false;
        });
        viewModel.isInit!.value = false;
      }
      return () {
        print("Disp home");
      };
    });
    return viewModel.isLoading!.value
        ? const LoadingView()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(AppDimensions.appBarHeight),
              child: CustomAppBar(
                  leadingWidth: viewModel.selectedIndex.value == 0 ? 120 : 200,
                  leading: viewModel.selectedIndex.value == 0
                      ? Image.asset(Constants.logoText)
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: AppDimensions.paddingMedium),
                          child: Text(viewModel.loggedInUser().username,
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                  actions: [
                    viewModel.selectedIndex.value == 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                right: AppDimensions.paddingMedium),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(Icons.favorite_border),
                                )
                              ],
                            ),
                          )
                        : Container()
                  ]),
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: AppColors.borderColor))),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  BottomNavigationBar(
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Image.asset(viewModel.selectedIndex.value == 0
                              ? AppIcons.selectedHomeIcon
                              : AppIcons.unSelectedHomeIcon),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Container(),
                          label: 'New Post',
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset(viewModel.selectedIndex.value == 2
                              ? AppIcons.selectedProfileIcon
                              : AppIcons.unSelectedProfileIcon),
                          label: 'Profile',
                        ),
                      ],
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      currentIndex: viewModel.selectedIndex.value,
                      selectedItemColor: AppColors.primaryTextColor,
                      backgroundColor: AppColors.bgColor,
                      onTap: viewModel.onItemTapped),
                  Positioned(
                    top: 14,
                    child: GestureDetector(
                        onTap: () =>
                            context.pushNamed(AppRoutes.addPostRouteName),
                        child: Image.asset(AppIcons.unSelectedAddIcon)),
                  ),
                ],
              ),
            ),
            body: viewModel.pages.elementAt(viewModel.selectedIndex.value),
          );
  }
}

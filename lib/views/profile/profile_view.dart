import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/resources/constants/routes/routes.dart';
import 'package:instagram_clone_app/viewmodels/profile/profile_viewmodel.dart';
import 'package:instagram_clone_app/views/loading_view.dart';
import 'package:instagram_clone_app/widgets/profile/profile_bio.dart';
import 'package:instagram_clone_app/widgets/profile/profile_button.dart';
import 'package:instagram_clone_app/widgets/profile/profile_followers.dart';
import 'package:instagram_clone_app/widgets/profile/profile_following.dart';
import 'package:instagram_clone_app/widgets/profile/profile_img.dart';
import 'package:instagram_clone_app/widgets/profile/profile_posts.dart';
import 'package:instagram_clone_app/widgets/profile/profile_name.dart';
import 'package:instagram_clone_app/widgets/profile/profile_posts_gridview.dart';

final profileViewModelProvider = ChangeNotifierProvider((ref) {
  return ProfileViewModel(ref);
});

class ProfileView extends HookConsumerWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(profileViewModelProvider);
    viewModel.isLoading = useState(false);
    viewModel.isInit = useState(true);
    if (viewModel.isInit!.value) {
      useEffect(() {
        if (viewModel.isInit!.value) {
          Future.microtask(() async {
            viewModel.isLoading!.value = true;
            await viewModel.fetchUserPosts();
            viewModel.isLoading!.value = false;
          });
          viewModel.isInit!.value = false;
        }
        return () {
          print("disp");
        };
      });
    }
    return viewModel.isLoading!.value 
    ? const LoadingView()
    : Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          clipBehavior: Clip.none,
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileImg(
                          imgUrl: viewModel.loggedInUser().profileImageUrl,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                ProfilePosts(
                                  posts: 5,
                                ),
                                Text(
                                  "Posts",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                ProfileFollowers(followers: 10),
                                Text(
                                  "Followers",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              children: [
                                ProfileFollowing(following: 20),
                                Text(
                                  "Following",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    ProfileName(
                      name: viewModel.loggedInUser().username,
                    ),
                    ProfileBio(bio: viewModel.loggedInUser().bio),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: ProfileButton(
                          title: "Edit profile",
                          onTap: () =>
                              context.pushNamed(AppRoutes.editProfileName),
                        )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: ProfileButton(
                          title: "Share profile",
                          onTap: () {},
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const TabBar(
                      dividerColor: AppColors.bgColor,
                      labelColor: AppColors.primaryTextColor,
                      unselectedLabelColor: AppColors.unselectedLabelColor,
                      indicatorColor: AppColors.primaryTextColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 0.5,
                      tabs: [
                        Tab(icon: Icon(Icons.grid_on)),
                        // Tab(icon: Icon(Icons.person_pin_outlined)),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ProfilePostsGridView(posts: viewModel.getUserPosts()),
              // const Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}

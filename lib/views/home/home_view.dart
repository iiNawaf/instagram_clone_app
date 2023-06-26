import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/resources/constants/routes/routes.dart';
import 'package:instagram_clone_app/viewmodels/home/home_viewmodel.dart';
import 'package:instagram_clone_app/views/app_manager/app_manager_view.dart';
import 'package:instagram_clone_app/widgets/home/post_caption.dart';
import 'package:instagram_clone_app/widgets/home/post_image.dart';
import 'package:instagram_clone_app/widgets/home/post_like_btn.dart';
import 'package:instagram_clone_app/widgets/home/post_likes_number.dart';
import 'package:instagram_clone_app/widgets/home/post_owner_img.dart';
import 'package:instagram_clone_app/widgets/home/post_owner_username.dart';

final homeViewModelProvider = ChangeNotifierProvider((ref) {
  return HomeViewModel(ref);
});

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appManagerviewModel = ref.watch(appManagerViewModelProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
                onPressed: () async {
                  await ref.read(homeViewModelProvider.notifier).logout();
                },
                child: const Text("Logout")),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appManagerviewModel.allPosts().length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.only(bottom: AppDimensions.marginValue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            right: AppDimensions.paddingMedium,
                            left: AppDimensions.paddingMedium),
                        child: ListTile(
                            onTap: () {
                              context.pushNamed(AppRoutes.userProfileName,
                                  pathParameters: {
                                    'id': appManagerviewModel
                                        .postsOwners[index].id
                                  });
                            },
                            contentPadding: EdgeInsets.zero,
                            leading: PostOwnerImg(
                              imgUrl: appManagerviewModel
                                  .postsOwners[index].profileImageUrl,
                            ),
                            title: PostOwnerUsername(
                              username: appManagerviewModel
                                  .postsOwners[index].username,
                            )),
                      ),
                      PostImage(
                          imgUrl: appManagerviewModel.allPosts()[index].imgUrl),
                      Container(
                          padding: const EdgeInsets.only(
                              right: AppDimensions.paddingMedium,
                              left: AppDimensions.paddingMedium),
                          margin: const EdgeInsets.only(
                              bottom: AppDimensions.marginValue),
                          child: PostLikeBtn(
                            btnAction: () {},
                          )),
                      Container(
                          padding: const EdgeInsets.only(
                              right: AppDimensions.paddingMedium,
                              left: AppDimensions.paddingMedium),
                          child: PostLikesNumber(
                            number: 100,
                          )),
                      Container(
                        padding: const EdgeInsets.only(
                            right: AppDimensions.paddingMedium,
                            left: AppDimensions.paddingMedium),
                        child: PostCaption(
                          username:
                              appManagerviewModel.allPosts()[index].caption,
                          caption:
                              appManagerviewModel.allPosts()[index].caption,
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

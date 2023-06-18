import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/resources/constants/dimensions/dimensions.dart';
import 'package:instagram_clone_app/viewmodels/home_viewmodel.dart';
import 'package:instagram_clone_app/widgets/home/post_like_btn.dart';
import 'package:instagram_clone_app/widgets/home/post_likes_number.dart';
import 'package:instagram_clone_app/widgets/home/post_owner_img.dart';
import 'package:instagram_clone_app/widgets/home/post_owner_username.dart';

class HomeView extends HookConsumerWidget {
  HomeView({super.key});

  HomeViewModel homeViewModel = HomeViewModel();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(onPressed: ()=> context.go('/login'), child: Text("Login")),
            Container(
              margin: const EdgeInsets.only(bottom: AppDimensions.marginValue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        right: AppDimensions.paddingMedium, left: AppDimensions.paddingMedium),
                    child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: PostOwnerImg(),
                        title: PostOwnerUsername(
                          username: "pew",
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: AppDimensions.marginValue),
                    height: 300,
                    color: Colors.blue,
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          right: AppDimensions.paddingMedium, left: AppDimensions.paddingMedium),
                      margin: const EdgeInsets.only(bottom: AppDimensions.marginValue),
                      child: PostLikeBtn(
                        btnAction: () {},
                      )),
                  Container(
                      padding: const EdgeInsets.only(
                          right: AppDimensions.paddingMedium, left: AppDimensions.paddingMedium),
                      child: PostLikesNumber(
                        number: 100,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
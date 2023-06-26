import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_app/models/post/post_model.dart';
import 'package:instagram_clone_app/resources/constants/colors/colors.dart';
import 'package:instagram_clone_app/resources/constants/routes/routes.dart';

class ProfilePostsGridView extends StatelessWidget {
  final List<PostModel> posts;
  const ProfilePostsGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.pushNamed(
              AppRoutes.postName,
              pathParameters: {
                'id': posts[index].id,
                },
              queryParameters: {
                'user_id': posts[index].userId
              });
          },
          child: Container(
              color: AppColors.containerBgColor,
              child: Image.network(
                posts[index].imgUrl,
                fit: BoxFit.fill,
              )),
        );
      },
    );
  }
}

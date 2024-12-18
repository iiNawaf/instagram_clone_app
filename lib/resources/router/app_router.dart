import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';
import 'package:instagram_clone_app/resources/constants/routes/routes.dart';
import 'package:instagram_clone_app/views/add_post/add_post_view.dart';
import 'package:instagram_clone_app/views/app_manager/app_manager_view.dart';
import 'package:instagram_clone_app/views/login/login_view.dart';
import 'package:instagram_clone_app/views/home/post_view.dart';
import 'package:instagram_clone_app/views/profile/edit_profile_view.dart';
import 'package:instagram_clone_app/views/profile/user_profile_view.dart';
import 'package:instagram_clone_app/views/sign_up/sign_up_password_view.dart';
import 'package:instagram_clone_app/views/sign_up/sign_up_username_view.dart';

class AppRouter {
  static GoRouter router(WidgetRef ref) {
    final userNotifier = ref.watch(userProvider.notifier);
    bool isDuplicated = false;

    return GoRouter(
        refreshListenable: userNotifier,
        redirect: (context, state) async {
          final isLoggedIn = userNotifier.loggedInUser != null;
          final isLoggingIn = state.location == AppRoutes.loginRoutePath;
          if (!isLoggedIn && !isLoggingIn && !isDuplicated) {
            isDuplicated = true;
            return AppRoutes.loginRoutePath;
          }
          return null;
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.appManagerRoutePath,
            name: AppRoutes.appManagerRouteName,
            builder: (BuildContext context, GoRouterState state) {
              return const AppManagerView();
            },
          ),
          GoRoute(
              path: AppRoutes.addPostRoutePath,
              name: AppRoutes.addPostRouteName,
              builder: (BuildContext context, GoRouterState state) {
                return AddPostView();
              }),
          GoRoute(
            path: AppRoutes.loginRoutePath,
            name: AppRoutes.loginRouteName,
            builder: (BuildContext context, GoRouterState state) {
              return const LoginView();
            },
          ),
          GoRoute(
            path: AppRoutes.signUpRouteUsernamePath,
            name: AppRoutes.signUpRouteUsernameName,
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpUsernameView();
            },
          ),
          GoRoute(
            path: AppRoutes.signUpRoutePasswordPath,
            name: AppRoutes.signUpRoutePasswordName,
            builder: (BuildContext context, GoRouterState state) {
              return SignUpPasswordView(
                email: state.queryParameters['email']!,
                username: state.queryParameters['username']!,
              );
            },
          ),
          GoRoute(
            path: AppRoutes.editProfilePath,
            name: AppRoutes.editProfileName,
            builder: (BuildContext context, GoRouterState state) {
              return EditProfileView();
            },
          ),
          GoRoute(
            path: '${AppRoutes.userProfilePath}/:id',
            name: AppRoutes.userProfileName,
            builder: (BuildContext context, GoRouterState state) {
              return UserProfileView(
                id: state.pathParameters['id']!,
              );
            },
          ),
          GoRoute(
            path: '${AppRoutes.postPath}/:id',
            name: AppRoutes.postName,
            builder: (BuildContext context, GoRouterState state) {
              return PostView(
                id: state.pathParameters['id']!,
                userId: state.queryParameters['user_id']!,
              );
            },
          ),
        ]);
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_app/views/add_post_view.dart';
import 'package:instagram_clone_app/views/app_manager_view.dart';
import 'package:instagram_clone_app/views/login_view.dart';
import 'package:instagram_clone_app/views/sign_up_view.dart';

final GoRouter appRouter = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AppManagerView();
      },
      routes: [
        GoRoute(
            path: 'add_post',
            builder: (BuildContext context, GoRouterState state) {
              return const AddPostView();
            })
      ]),
  GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
      routes: [
        GoRoute(
            path: 'sign_up',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpView();
            })
      ])
]);

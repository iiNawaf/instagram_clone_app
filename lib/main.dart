import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';
import 'package:instagram_clone_app/resources/router/app_router.dart';
import 'package:instagram_clone_app/resources/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://dyjvoegoyuyzmqxwaoma.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR5anZvZWdveXV5em1xeHdhb21hIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODcxNDAwMDIsImV4cCI6MjAwMjcxNjAwMn0.niVtVUy72Sgw06hJKjumxEXrlt4GYFJSGEEuuMT6f1E');
  runApp(ProviderScope(child: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends HookConsumerWidget {
  MyApp({super.key});

  bool isInit = true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    useEffect(() {
      if (isInit) {
        Future.microtask(() async {
          await user.autoLogin();
        });
        isInit = false;
      }
      return null;
    });
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router(ref),
      // routeInformationProvider: AppRouter.router(ref).routeInformationProvider,
      // routeInformationParser: AppRouter.router(ref).routeInformationParser,
      // routerDelegate: AppRouter.router(ref).routerDelegate,
    );
  }
}

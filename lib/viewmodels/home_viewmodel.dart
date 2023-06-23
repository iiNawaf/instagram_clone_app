import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef<Object?> ref;
  HomeViewModel(this.ref);

  Future<void> logout() async {
    await ref.read(userProvider).logout();
    notifyListeners();
  }
}

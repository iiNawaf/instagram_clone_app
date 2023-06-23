import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef<Object?> ref;
  LoginViewModel(this.ref);

  Future<bool> login(String email, String password) async {
    try {
      final user = await ref.read(userProvider).login(email, password);
      if (user != null) {
        // notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Login failed $e");
      return false;
    }
  }
}

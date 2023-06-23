import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef<Object?> ref;
  SignUpViewModel(this.ref);

  Future<bool> signUp(String email, String password, String username) async {
    try {
      final userResult =
          await ref.read(userProvider).signUp(email, password, username);
      print("userResult: $userResult");
      if (userResult != null) {
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("Create ViewModel Error: $e");
      return false;
    }
  }

  Future<bool> isUsernameExist(String username) async {
    final isUsernameExist =
        await ref.read(userProvider).isUsernameAlreadyExist(username);
    return isUsernameExist;
  }

  Future<bool> isEmailExist(String email) async {
    final isEmailExist =
        await ref.read(userProvider).isEmailAlreadyExist(email);
    return isEmailExist;
  }
}

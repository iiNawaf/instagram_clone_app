import 'package:flutter/material.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';
import 'package:instagram_clone_app/services/auth_service.dart';

class SignUpViewModel extends ChangeNotifier {
  AuthService authService = AuthService();
  UserRepository userRepository = UserRepository();

  Future<bool> signUp(String email, String password, String username) async {
    try {
      final userResult = await userRepository.signUp(email, password, username);
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
}

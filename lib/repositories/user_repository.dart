import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:instagram_clone_app/services/auth_service.dart';
import 'package:instagram_clone_app/services/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = ChangeNotifierProvider((ref) => UserRepository());

class UserRepository extends ChangeNotifier {
  DatabaseService databaseService = DatabaseService();
  AuthService authService = AuthService();

  UserModel? _loggedInUser;
  UserModel? get loggedInUser => _loggedInUser;

  Future<UserModel?> signUp(
      String email, String password, String username) async {
    try {
      final authUser = await authService.signUp(email, password);
      if (authUser != null) {
        _loggedInUser =
            UserModel(id: authUser.id, email: email, username: username);
        await databaseService.createUser(_loggedInUser!);
        await storeUserDataLocally(_loggedInUser!);
        notifyListeners();
        return _loggedInUser;
      }
    } catch (e) {
      print("SignUp Failed Repo: $e");
      return null;
    }
    return null;
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final authUser = await authService.login(email, password);
      if (authUser != null) {
        final retrievedUser = await databaseService.getUserById(authUser.id);
        _loggedInUser = UserModel(
            id: retrievedUser['id'],
            email: retrievedUser['email'],
            username: retrievedUser['username']);
        await storeUserDataLocally(_loggedInUser!);
        await autoLogin();
        notifyListeners();
        return _loggedInUser;
      }
    } catch (e) {
      print("Login Failed Repo $e");
    }
    return null;
  }

  Future<void> logout() async {
    await authService.logout();
    await removeUserDataLocally();
    _loggedInUser = null;
    notifyListeners();
  }

  Future<bool> isUserAuthenticated() async {
    return await authService.isUserAuthenticated();
  }

  Future<void> storeUserDataLocally(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDataJson = jsonEncode(userModel.toJson());
    await prefs.setString("userData", userDataJson);
  }

  Future<bool> isUserLocalDataExist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final isUserDataExist = prefs.containsKey("userData");
    if (isUserDataExist) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> removeUserDataLocally() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("userData");
  }

  Future<bool> autoLogin() async {
    final isAuth = await isUserAuthenticated();
    final isLocalDataExist = await isUserLocalDataExist();
    if (isAuth && isLocalDataExist) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = jsonDecode(prefs.getString("userData")!);
      _loggedInUser = UserModel(
          id: data['id'], email: data['email'], username: data['username']);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}

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

  // -------- Authentication --------
  Future<UserModel?> signUp(
      String email, String password, String username) async {
    try {
      final authUser = await authService.signUp(email, password);
      if (authUser != null) {
        _loggedInUser = UserModel(
            name: "",
            id: authUser.id,
            email: email,
            username: username,
            profileImageUrl: "",
            bio: "");
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
        fillUserModel(retrievedUser);
        // _loggedInUser = UserModel(
        //     id: retrievedUser['id'],
        //     email: retrievedUser['email'],
        //     username: retrievedUser['username'],
        //     profileImageUrl: "",
        //     bio: retrievedUser['bio']);
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

  Future<bool> autoLogin() async {
    final isAuth = await isUserAuthenticated();
    final isLocalDataExist = await isUserLocalDataExist();
    if (isAuth && isLocalDataExist) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = jsonDecode(prefs.getString("userData")!);
      fillUserModel(data);
      // _loggedInUser = UserModel(
      //   name: data['name'],
      //     id: data['id'],
      //     email: data['email'],
      //     username: data['username'],
      //     profileImageUrl: "",
      //     bio: data['bio']);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  // -------- End of Authentication --------

  // -------- Local Storage methods --------
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

  void fillUserModel(Map<String, dynamic> data) async {
    _loggedInUser = UserModel(
        id: data['id'] ?? "",
        name: data['name'] ?? "",
        email: data['email'] ?? "",
        username: data['username'] ?? "",
        profileImageUrl: "",
        bio: data['bio'] ?? "");
  }

  // -------- End of Local Storage methods --------

  // -------- Database methods --------

  Future<bool> updateUserProfile(Map<String, dynamic> userObj) async {
    try {
      fillUserModel(userObj);
      await databaseService.updateUser(userObj, _loggedInUser!.id);
      // _loggedInUser = UserModel(
      //     name: userObj['name'],
      //     id: _loggedInUser!.id,
      //     email: userObj['email'],
      //     username: userObj['username'],
      //     profileImageUrl: "",
      //     bio: userObj['bio']);
      await storeUserDataLocally(_loggedInUser!);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: $e");
      return false;
    }
  }

  // --------  End of Database methods --------

  // -------- Database validations --------
  Future<bool> isUsernameAlreadyExist(String username) async {
    List<dynamic> data = await databaseService.getUserByUsername(username);
    final search = data.where((element) => username == element['username']);
    print(search);
    return search.isNotEmpty;
  }

  Future<bool> isEmailAlreadyExist(String email) async {
    List<dynamic> data = await databaseService.getUserByEmail(email);
    if (data.isNotEmpty) return true;
    return false;
  }
  // -------- End of Database validations --------
}

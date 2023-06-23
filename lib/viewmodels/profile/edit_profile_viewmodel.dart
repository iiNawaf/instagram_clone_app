import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/models/user/user_model.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';

class EditProfileViewModel extends ChangeNotifier {
  ChangeNotifierProviderRef<Object?> ref;
  EditProfileViewModel(this.ref);

  UserModel loggedInUser() {
    return ref.read(userProvider).loggedInUser!;
  }

  Future<bool> updateUserProfile(
      String name, String username, String email, String bio) async {
    final user = ref.read(userProvider);
    bool isUsernameAlreadyExist = await user.isUsernameAlreadyExist(username);
    if(isUsernameAlreadyExist && username != user.loggedInUser!.username){
      print("Username Used!");
      return false;
    }
    await user.updateUserProfile(
        {'id': user.loggedInUser!.id,'name': name, 'username': username, 'email': email, 'bio': bio});
    notifyListeners();
    return true;
  }
}

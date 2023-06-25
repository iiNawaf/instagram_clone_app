import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/repositories/user_repository.dart';
import 'package:instagram_clone_app/services/database_service.dart';
import 'package:instagram_clone_app/services/storage_service.dart';
import 'package:uuid/uuid.dart';

final postProvider = ChangeNotifierProvider((ref) {
  return PostRepository(ref);
});

class PostRepository extends ChangeNotifier {
  ChangeNotifierProviderRef<Object?> ref;
  PostRepository(this.ref);

  DatabaseService databaseService = DatabaseService();
  StorageService storageService = StorageService();

  Future<bool> uploadPost(File imageFile, String caption) async {
    try {
      final fileName = "post-${DateTime.now().microsecondsSinceEpoch}";
      final imageUrl = await storageService.uploadImage(imageFile, "post", fileName);
      final postId = await newPostId();
      await databaseService.createPost({
        'id': postId,
        'user_id': ref.read(userProvider).loggedInUser!.id,
        'imgUrl': imageUrl,
        'caption': caption,
      });
      notifyListeners();
      return true;
    } catch (e) {
      print("FAILED: $e");
      return false;
    }
  }

  Future<String> newPostId() async{
    var uuid = Uuid();
    return uuid.v1();
  }
}

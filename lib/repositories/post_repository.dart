import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/models/post/post_model.dart';
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

  List<PostModel> _userPosts = [];
  List<PostModel> get userPosts => _userPosts;

  Future<bool> uploadPost(File imageFile, String caption) async {
    try {
      final fileName = "post-${DateTime.now().microsecondsSinceEpoch}";
      final imageUrl =
          await storageService.uploadImage(imageFile, "posts", fileName);
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

  Future<String> newPostId() async {
    var uuid = const Uuid();
    return uuid.v1();
  }

  Future<bool> fetchAllPosts() async {
    try {
      _userPosts = [];
      final posts = await databaseService.fetchAllPosts();
      posts.forEach((post) {
        _userPosts.add(PostModel(
            id: post['id'],
            userId: post['user_id'],
            imgUrl: post['imgUrl'],
            caption: post['caption'],
            createdAt: post['created_at']));
      });
      notifyListeners();
      return true;
    } catch (e) {
      print("Error fetching: $e");
      return false;
    }
  }

  Future<bool> fetchUserPost(String uid) async {
    try {
      _userPosts = [];
      final posts = await databaseService.fetchUserPosts(uid);
      posts.forEach((post) {
        _userPosts.add(PostModel(
            id: post['id'],
            userId: post['user_id'],
            imgUrl: post['imgUrl'],
            caption: post['caption'],
            createdAt: post['created_at']));
      });
      notifyListeners();
      return true;
    } catch (e) {
      print("error $e");
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchPostOwnerData(String uid) async {
    return await databaseService.getUserById(uid);
  }
}

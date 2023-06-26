import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_app/models/post/post_model.dart';
import 'package:instagram_clone_app/repositories/post_repository.dart';

class PostViewModel extends ChangeNotifier {
  ChangeNotifierProviderRef<Object?> ref;
  PostViewModel(this.ref);

  ValueNotifier<bool>? isInit;
  ValueNotifier<bool>? isLoading;
  ValueNotifier<Map<String, dynamic>>? postOwnerData;

  PostModel post(String id) {
    final posts = ref.read(postProvider).userPosts;
    return posts.firstWhere((post) => post.id == id);
  }

  Future<void> fetchPostOwnerData(String uid) async {
    final user = await ref.read(postProvider).fetchPostOwnerData(uid);
    postOwnerData!.value = user;
    notifyListeners();
  }
}

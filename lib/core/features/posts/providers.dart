import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';
import 'models/post.dart';
import 'posts_controller.dart';

final postsControllerProvider = StateNotifierProvider<PostsController, bool>(
    (ref) => PostsController(dio: ref.watch(dioProvider)));

final getPostsProvider = FutureProvider<List<Post>>((ref) async {
  final postsController = ref.watch(postsControllerProvider.notifier);
  return await postsController.getPosts();
});

final getPostByIdProvider =
    FutureProvider.family<Post, String>((ref, id) async {
  final postsController = ref.watch(postsControllerProvider.notifier);
  return await postsController.getPostById(id);
});

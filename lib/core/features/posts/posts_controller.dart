import 'package:altlink/core/constants/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/post.dart';

class PostsController extends StateNotifier<bool> {
  PostsController({required Dio dio})
      : _dio = dio,
        super(false);

  final Dio _dio;

  Future<List<Post>> getPosts() async {
    try {
      final res = await _dio.get(Endpoints.posts);
      debugPrint('res: $res');
      final posts = res.data['posts'] as List<dynamic>;
      return posts.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      debugPrint('e: $e');
      rethrow;
    }
  }
}

import 'package:altlink/core/constants/endpoints.dart';
import 'package:altlink/core/utils/functions.dart';
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

  Future<bool> createPost(Post post) async {
    state = true;
    bool isSuccess = false;
    try {
      await _dio.post(Endpoints.posts, data: post.toJson());
      isSuccess = true;
    } on DioException catch (e) {
      debugPrint('DioError - createPost: ${e.response}');
      showSnackBar(e.response?.data['message'] ?? 'Something went wrong');
    } catch (e) {
      debugPrint('Error - createPost: $e');
    } finally {
      state = false;
    }
    return isSuccess;
  }
}

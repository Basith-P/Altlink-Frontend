import 'dart:io';

import 'package:altlink/core/constants/endpoints.dart';
import 'package:altlink/core/constants/strings.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:uuid/uuid.dart';

import 'models/post.dart';

class PostsController extends StateNotifier<bool> {
  PostsController({required Dio dio})
      : _dio = dio,
        super(false);

  final Dio _dio;

  Future<List<Post>> getPosts() async {
    try {
      final res = await _dio.get(Endpoints.posts);
      final posts = res.data[Strings.posts] as List<dynamic>;
      return posts.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      debugPrint('e: $e');
      rethrow;
    }
  }

  Future<bool> createOrUpdatePost({
    required Post post,
    File? image,
    bool isUpdate = false,
  }) async {
    state = true;
    bool isSuccess = false;
    try {
      MediaType? mediaType;
      if (image != null) {
        const allowedMimeTypes = ['jpg', 'jpeg', 'png'];
        final mimeType = image.path.split('.').last.toLowerCase();
        if (allowedMimeTypes.contains(mimeType)) {
          mediaType = MediaType('image', mimeType);
        }
      }
      final formData = FormData.fromMap({
        ...post.toJson(),
        Strings.image: image != null
            ? await MultipartFile.fromFile(
                image.path,
                filename: const Uuid().v4(),
                contentType: mediaType,
              )
            : null,
      });
      dynamic res;
      if (!isUpdate) {
        res = await _dio.post(Endpoints.posts, data: formData);
      } else {
        res = await _dio.put('${Endpoints.posts}/${post.id}', data: formData);
      }
      debugPrint('res: $res');
      isSuccess = true;
    } on DioException catch (e) {
      debugPrint('DioError - createPost: ${e.response}');
      showSnackBar(e.response?.data[Strings.message] ?? 'Something went wrong');
    } catch (e) {
      debugPrint('Error - createPost: $e');
    } finally {
      state = false;
    }
    return isSuccess;
  }

  Future<Post> getPostById(String id) async {
    try {
      final res = await _dio.get('${Endpoints.posts}/$id');
      debugPrint('res: $res');
      return Post.fromJson(res.data[Strings.post]);
    } catch (e) {
      debugPrint('e: $e');
      rethrow;
    }
  }

  Future<bool> deletePost(String id) async {
    debugPrint('id: $id');
    state = true;
    bool isSuccess = false;
    try {
      final res = await _dio.delete('${Endpoints.posts}/$id');
      debugPrint('res: $res');
      isSuccess = true;
    } on DioException catch (e) {
      debugPrint('DioError - deletePost: ${e.response}');
      showSnackBar(e.response?.data[Strings.message] ?? 'Something went wrong');
    } catch (e) {
      debugPrint('Error - deletePost: $e');
    } finally {
      state = false;
    }
    return isSuccess;
  }
}

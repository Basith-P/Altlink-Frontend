import 'package:altlink/core/constants/endpoints.dart';
import 'package:altlink/core/constants/strings.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseAuthController {
  Future<bool> signUp(String name, String email, String password);
}

class AuthController extends StateNotifier<bool> implements BaseAuthController {
  AuthController({required Dio dio})
      : _dio = dio,
        super(false);

  final Dio _dio;

  // final AuthRepository _authRepository;

  @override
  Future<bool> signUp(String name, String email, String password) async {
    state = true;
    bool isSuccessful = false;
    debugPrint('DATA: $name, $email, $password');
    try {
      final res = await _dio.post(
        Endpoints.signup,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      debugPrint("USER REGISTERED: $res");
      isSuccessful = true;
    } on DioException catch (e) {
      showSnackBar(
          e.response?.data?[Strings.message] ?? 'Something went wrong');
      debugPrint(e.message);
    } catch (e) {
      debugPrint("USER REGISTRATION FAILED: $e");
    } finally {
      state = false;
    }
    return isSuccessful;
  }
}

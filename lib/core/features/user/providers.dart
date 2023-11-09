import 'package:altlink/core/features/user/auth_controller.dart';
import 'package:altlink/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final authControllerProvider =
//     Provider((ref) => AuthController(dio: ref.read(dioProvider)));

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(dio: ref.read(dioProvider)));

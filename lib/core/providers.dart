import 'package:altlink/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final dioProvider = Provider((_) => Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        // contentType: 'application/json',
      ),
    ));

final imagePickerProvider = Provider((_) => ImagePicker());

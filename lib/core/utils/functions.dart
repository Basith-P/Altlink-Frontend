import 'dart:io';

import 'package:altlink/core/global_keys.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void showSnackBar(String message) {
  final snackBar = SnackBar(content: Text(message));
  scaffoldMessengerKey.currentState!
    ..clearSnackBars()
    ..showSnackBar(snackBar);
}

final navState = navigatorKey.currentState;

void push(String routeName, {args}) =>
    navState!.pushNamed(routeName, arguments: args);
void replace(String routeName) => navState!.pushReplacementNamed(routeName);
void pop() => navState!.pop();
void replaceAll(String routeName) =>
    navState!.pushNamedAndRemoveUntil(routeName, (route) => false);

Future<File?> picKImageFromGallery(ImagePicker picker) async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  return pickedFile != null ? File(pickedFile.path) : null;
}

String getPostTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  final days = difference.inDays;

  if (days > 0) {
    return '${DateFormat.yMMMd().format(dateTime)} '
        'at ${DateFormat.jm().format(dateTime)}';
  } else {
    return DateFormat.jm().format(dateTime);
  }
}

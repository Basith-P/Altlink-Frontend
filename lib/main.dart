import 'package:altlink/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'app.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(Strings.userBox);
  runApp(const ProviderScope(child: App()));
}

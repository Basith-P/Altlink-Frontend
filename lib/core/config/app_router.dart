import 'package:altlink/core/common/views/main_layout.dart';
import 'package:altlink/core/features/posts/pages/create_post_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainLayout());
      case CreatePostPage.routeName:
        return MaterialPageRoute(builder: (_) => const CreatePostPage());
      default:
        return MaterialPageRoute(builder: (_) => const MainLayout());
    }
  }
}

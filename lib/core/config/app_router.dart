import 'package:altlink/core/common/views/main_layout.dart';
import 'package:altlink/core/features/posts/pages/create_post_page.dart';
import 'package:altlink/core/features/posts/pages/post_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainLayout());
      case CreatePostPage.routeName:
        return MaterialPageRoute(builder: (_) => const CreatePostPage());
      case PostPage.routeName:
        return MaterialPageRoute(builder: (_) => PostPage(id: args as String));
      default:
        return MaterialPageRoute(builder: (_) => const MainLayout());
    }
  }
}

import 'package:altlink/core/features/posts/widgets/feed.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  static const routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Altlink',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                // final userbox = Hive.box(Strings.userBox);
                // final token = userbox.get(Strings.user);
                // debugPrint(token.toString());
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: const Feed(),
    );
  }
}

import 'package:altlink/core/features/posts/widgets/feed.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Altlink'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: const Feed(),
    );
  }
}

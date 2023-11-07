import 'package:altlink/core/features/posts/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Feed extends ConsumerWidget {
  const Feed({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getPostsProvider).when(
          data: (posts) => ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(posts[i].title),
            ),
          ),
          error: (e, st) {
            debugPrint('e: $e');
            return Center(child: Text(e.toString()));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

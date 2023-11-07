import 'package:altlink/core/common/views/error_page.dart';
import 'package:altlink/core/common/widgets/loaders.dart';
import 'package:altlink/core/features/posts/pages/create_post_page.dart';
import 'package:altlink/core/features/posts/pages/post_page.dart';
import 'package:altlink/core/features/posts/providers.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Feed extends ConsumerWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getPostsProvider).when(
            data: (posts) => ListView.builder(
              itemCount: posts.length,
              itemBuilder: (_, i) => ListTile(
                onTap: () => push(PostPage.routeName, args: posts[i].id),
                title: Text(posts[i].title),
                subtitle: Text(posts[i].content),
              ),
            ),
            error: (e, st) {
              debugPrint('e: $e');
              return const ErrorDisplay();
            },
            loading: () => loaderPrimary,
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => push(CreatePostPage.routeName),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

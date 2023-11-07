import 'package:altlink/core/common/views/error_page.dart';
import 'package:altlink/core/common/widgets/loaders.dart';
import 'package:altlink/core/features/posts/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostPage extends ConsumerWidget {
  const PostPage({super.key, required this.id});

  final String id;

  static const routeName = '/post';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(getPostByIdProvider(id)).when(
            data: (post) => SingleChildScrollView(
              child: Column(
                children: [
                  Text(post.title),
                  Text(post.content),
                ],
              ),
            ),
            error: (e, st) => const ErrorDisplay(),
            loading: () => loaderPrimary,
          ),
    );
  }
}

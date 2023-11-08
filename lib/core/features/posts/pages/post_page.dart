import 'package:altlink/core/common/views/error_page.dart';
import 'package:altlink/core/common/widgets/loaders.dart';
import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:altlink/core/features/posts/pages/create_post_page.dart';
import 'package:altlink/core/features/posts/providers.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
// import 'package:timeago/timeago.dart' as timeago;

class PostPage extends ConsumerWidget {
  const PostPage({super.key, required this.id});

  final String id;

  static const routeName = '/post';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    void deletePost() async {
      final isSuccess =
          await ref.read(postsControllerProvider.notifier).deletePost(id);
      if (isSuccess) {
        ref.refresh(getPostsProvider);
        pop();
      }
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

    return ref.watch(getPostByIdProvider(id)).when(
          data: (post) => Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () => push(CreatePostPage.routeName, args: post),
                  icon: const Icon(Icons.edit_rounded),
                ),
                IconButton(
                  onPressed: deletePost,
                  icon: const Icon(Icons.delete_rounded),
                )
              ],
            ),
            body: SingleChildScrollView(
              padding: kPaddingMd,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(post.title, style: textTheme.titleLarge),
                  gapH4,
                  // time and date
                  Text(getPostTime(post.createdAt!),
                      style: textTheme.bodySmall),
                  gapH12,
                  Text(post.content),
                ],
              ),
            ),
          ),
          error: (e, st) => const ErrorPage(),
          loading: () => loaderPrimaryPage,
        );
  }
}

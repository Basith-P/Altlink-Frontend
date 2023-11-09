import 'package:altlink/core/common/views/error_page.dart';
import 'package:altlink/core/common/widgets/loaders.dart';
import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:altlink/core/features/posts/pages/create_post_page.dart';
import 'package:altlink/core/features/posts/providers.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:timeago/timeago.dart' as timeago;

class PostPage extends ConsumerWidget {
  const PostPage({super.key, required this.id});

  final String id;

  static const routeName = '/post';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    void deletePost() async {
      final isSuccess =
          await ref.read(postsControllerProvider.notifier).deletePost(id);
      if (isSuccess) {
        // ref.refresh(getPostsProvider);
        pop();
      }
    }

    return ref.watch(getPostByIdProvider(id)).when(
          data: (post) => Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    foregroundImage: CachedNetworkImageProvider(
                      'https://www.bentbusinessmarketing.com/wp-content/uploads/2013/02/35844588650_3ebd4096b1_b-1024x683.jpg',
                    ),
                  ),
                  gapW8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('__user_an_', style: textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () => push(CreatePostPage.routeName, args: post),
                  icon: const Icon(FluentIcons.edit_24_regular),
                ),
                IconButton(
                  onPressed: deletePost,
                  icon: const Icon(FluentIcons.delete_24_regular),
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
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: (size.height - kSpacingMd) / 4 * 5),
                    decoration: const BoxDecoration(
                      borderRadius: kBorderRadiusMd,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://media.istockphoto.com/id/1470130937/photo/young-plants-growing-in-a-crack-on-a-concrete-footpath-conquering-adversity-concept.webp?b=1&s=170667a&w=0&k=20&c=IRaA17rmaWOJkmjU_KD29jZo4E6ZtG0niRpIXQN17fc=',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
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

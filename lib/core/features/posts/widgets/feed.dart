import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:altlink/core/features/posts/models/post.dart';
import 'package:altlink/core/features/posts/pages/create_post_page.dart';
import 'package:altlink/core/features/posts/pages/post_page.dart';
import 'package:altlink/core/features/posts/providers.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:timeago/timeago.dart' as timeago;

class Feed extends ConsumerStatefulWidget {
  const Feed({super.key});

  @override
  ConsumerState<Feed> createState() => _FeedState();
}

class _FeedState extends ConsumerState<Feed> {
  final int _perPage = 5;

  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newPosts = await ref
          .read(postsControllerProvider.notifier)
          .getPosts(currentPage: pageKey ~/ _perPage + 1);
      final isLastPage = newPosts.length < _perPage;
      if (isLastPage) {
        _pagingController.appendLastPage(newPosts);
      } else {
        final nextPageKey = pageKey + newPosts.length;
        _pagingController.appendPage(newPosts, nextPageKey);
      }
    } catch (e) {
      debugPrint('e: $e');
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: PagedListView.separated(
          padding: kPaddingMd,
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Post>(
            itemBuilder: (_, post, __) => FeedPost(post: post),
          ),
          separatorBuilder: (context, index) => gapH12,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => push(CreatePostPage.routeName),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class FeedPost extends StatelessWidget {
  const FeedPost({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => push(PostPage.routeName, args: post.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                foregroundImage: CachedNetworkImageProvider(
                  'https://www.bentbusinessmarketing.com/wp-content/uploads/2013/02/35844588650_3ebd4096b1_b-1024x683.jpg',
                ),
              ),
              gapW8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title),
                ],
              ),
            ],
          ),
          gapH12,
          Container(
            constraints:
                BoxConstraints(maxHeight: (size.height - kSpacingMd) / 4 * 5),
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
          gapH8,
          Text(
            timeago.format(post.createdAt!.toLocal()),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          gapH20,
        ],
      ),
    );
  }
}

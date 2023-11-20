import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:altlink/core/features/posts/models/post.dart';
import 'package:altlink/core/features/posts/pages/create_post_page.dart';
import 'package:altlink/core/features/posts/providers.dart';
import 'package:altlink/core/features/posts/widgets/feed_post.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
          padding: kPaddingSm,
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

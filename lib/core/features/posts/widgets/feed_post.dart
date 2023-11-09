import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:altlink/core/features/posts/models/post.dart';
import 'package:altlink/core/features/posts/pages/post_page.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedPost extends StatelessWidget {
  const FeedPost({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

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
                  Text('__user_an_', style: textTheme.labelLarge),
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
          Text(post.title, style: textTheme.titleMedium),
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

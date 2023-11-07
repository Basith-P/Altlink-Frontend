import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePostPage extends ConsumerWidget {
  const CreatePostPage({super.key});

  static const routeName = '/create-post';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Post')),
      body: Form(
        child: ListView(
          padding: kPaddingSm,
          children: [
            TextFormField(
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Title',
                labelText: 'Title',
              ),
            ),
            gapH12,
            TextFormField(
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Content',
                labelText: 'Content',
              ),
              maxLength: 280,
              maxLines: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.send_rounded),
      ),
    );
  }
}

import 'dart:io';

import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:altlink/core/features/posts/models/post.dart';
import 'package:altlink/core/features/posts/providers.dart';
import 'package:altlink/core/features/posts/widgets/image_selector.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key, this.post});

  final Post? post;

  static const routeName = '/create-post';

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late ValueNotifier<File?> _imageNotifier;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController(text: widget.post?.title);
    _contentController = TextEditingController(text: widget.post?.content);
    _imageNotifier = ValueNotifier(null);
  }

  void submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final postsController = ref.read(postsControllerProvider.notifier);
      final post = Post(
        id: widget.post?.id,
        title: _titleController.text,
        content: _contentController.text,
      );
      final isUpdate = widget.post != null;

      final isSuccess = await postsController.createOrUpdatePost(
        post: post,
        image: _imageNotifier.value,
        isUpdate: isUpdate,
      );
      if (isSuccess) {
        if (isUpdate) ref.refresh(getPostByIdProvider(post.id!));
        // ref.refresh(getPostsProvider);
        pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(postsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('New Post')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: kPaddingSm,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: kTextFieldDecorationDark.copyWith(
                hintText: 'Title',
                labelText: 'Title',
              ),
              buildCounter: removeTextFieldCounter,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 50,
              validator: (val) => (val == null || val.trim().length < 3)
                  ? 'Please enter at least 3 characters'
                  : null,
            ),
            gapH4,
            ImageSelector(imageNotifier: _imageNotifier),
            gapH12,
            TextFormField(
              controller: _contentController,
              decoration: kTextFieldDecorationDark.copyWith(
                hintText: 'Content',
                labelText: 'Content',
              ),
              buildCounter: removeTextFieldCounter,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 280,
              maxLines: null,
              validator: (val) => (val == null || val.trim().length < 3)
                  ? 'Please enter at least 3 characters'
                  : null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoading ? null : submit,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Icon(FluentIcons.send_24_regular),
      ),
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _imageNotifier.dispose();
    super.dispose();
  }
}

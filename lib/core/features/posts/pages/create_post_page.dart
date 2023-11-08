import 'dart:io';

import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:altlink/core/features/posts/models/post.dart';
import 'package:altlink/core/features/posts/providers.dart';
import 'package:altlink/core/providers.dart';
import 'package:altlink/core/utils/functions.dart';
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
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Title',
                labelText: 'Title',
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLength: 50,
              validator: (val) => (val == null || val.trim().length < 3)
                  ? 'Please enter at least 3 characters'
                  : null,
            ),
            gapH12,
            ImageSelector(imageNotifier: _imageNotifier),
            gapH12,
            TextFormField(
              controller: _contentController,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Content',
                labelText: 'Content',
              ),
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
            : const Icon(Icons.send_rounded),
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

class ImageSelector extends ConsumerWidget {
  const ImageSelector({super.key, required ValueNotifier<File?> imageNotifier})
      : _imageNotifier = imageNotifier;

  final ValueNotifier<File?> _imageNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          ValueListenableBuilder<File?>(
            valueListenable: _imageNotifier,
            builder: (_, image, __) {
              if (image != null) {
                return Image.file(image,
                    fit: BoxFit.cover, width: double.infinity);
              }
              return const SizedBox.shrink();
            },
          ),
          Center(
            child: IconButton(
              onPressed: () async {
                final picker = ref.read(imagePickerProvider);
                final image = await picKImageFromGallery(picker);
                if (image != null) {
                  _imageNotifier.value = image;
                }
              },
              icon: const Icon(Icons.add_a_photo_rounded),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

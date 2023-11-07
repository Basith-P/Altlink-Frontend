import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:altlink/core/features/posts/models/post.dart';
import 'package:altlink/core/features/posts/providers.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  static const routeName = '/create-post';

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  void submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final postsController = ref.read(postsControllerProvider.notifier);
      final post = Post(
        title: _titleController.text,
        content: _contentController.text,
      );
      final isSuccess = await postsController.createPost(post);
      if (isSuccess) {
        ref.refresh(getPostsProvider);
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
              maxLength: 50,
              validator: (val) => (val == null || val.trim().length < 3)
                  ? 'Please enter at least 3 characters'
                  : null,
            ),
            gapH12,
            TextFormField(
              controller: _contentController,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Content',
                labelText: 'Content',
              ),
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
    super.dispose();
  }
}

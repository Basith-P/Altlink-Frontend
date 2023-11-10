import 'package:altlink/core/common/views/main_layout.dart';
import 'package:altlink/core/common/widgets/loaders.dart';
import 'package:altlink/core/config/theme/app_colors.dart';
import 'package:altlink/core/constants/gaps.dart';
import 'package:altlink/core/constants/ui_constants.dart';
import 'package:altlink/core/features/user/providers.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  static const routeName = '/signup';

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late ValueNotifier<bool> _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _isPasswordVisible = ValueNotifier(false);
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      final isSuccess = await ref
          .read(authControllerProvider.notifier)
          .signUp(name, email, password);
      if (isSuccess) push(MainLayout.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: kPaddingMd,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create your\nAccount',
                style: textTheme.displaySmall,
              ),
              gapH36,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: kTextFieldDecorationDark.copyWith(
                          hintText: 'Full Name'),
                    ),
                    gapH16,
                    TextFormField(
                      controller: _emailController,
                      decoration:
                          kTextFieldDecorationDark.copyWith(hintText: 'Email'),
                    ),
                    gapH16,
                    ValueListenableBuilder(
                      valueListenable: _isPasswordVisible,
                      builder: (_, bool isPasswordVisible, __) {
                        return TextFormField(
                          controller: _passwordController,
                          decoration: kTextFieldDecorationDark.copyWith(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () => _isPasswordVisible.value =
                                  !_isPasswordVisible.value,
                              icon: Icon(
                                isPasswordVisible
                                    ? FluentIcons.eye_24_regular
                                    : FluentIcons.eye_off_24_regular,
                                color: AppColors.lightText,
                              ),
                            ),
                          ),
                          obscureText: !isPasswordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              gapH16,
              FilledButton(
                onPressed: isLoading ? () {} : submit,
                child: isLoading ? loaderOnButton : const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }
}

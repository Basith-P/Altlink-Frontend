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

class LoginOrSignupPage extends ConsumerStatefulWidget {
  const LoginOrSignupPage({super.key, this.isRegistering = false});

  final bool isRegistering;

  static const routeName = '/login-or-signup';

  @override
  ConsumerState<LoginOrSignupPage> createState() => _LoginOrSignupPageState();
}

class _LoginOrSignupPageState extends ConsumerState<LoginOrSignupPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late ValueNotifier<bool> _isPasswordVisible;
  late bool _isRegistering;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _isPasswordVisible = ValueNotifier(false);
    _isRegistering = widget.isRegistering;
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      final authNotifier = ref.read(authControllerProvider.notifier);
      final isSuccess = _isRegistering
          ? await authNotifier.signUp(name, email, password)
          : await authNotifier.signIn(email, password);
      if (isSuccess) replace(MainLayout.routeName);
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
                // 'Create your\nAccount',
                '${_isRegistering ? 'Create ' : 'Log in to '}your \nAccount',
                style: textTheme.displaySmall,
              ),
              gapH36,
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (_isRegistering) ...[
                      TextFormField(
                        controller: _nameController,
                        decoration: kTextFieldDecorationDark.copyWith(
                            hintText: 'Full Name'),
                      ),
                      gapH16,
                    ],
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
                child: isLoading
                    ? loaderOnButton
                    : Text(_isRegistering ? 'Sign Up' : 'Log In'),
              ),
              gapH16,
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    _isRegistering
                        ? 'Already have an account? '
                        : 'Don\'t have an account? ',
                    style: textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () =>
                        setState(() => _isRegistering = !_isRegistering),
                    child: Text(
                      _isRegistering ? 'Log In' : 'Sign Up',
                      style: textTheme.labelMedium!.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              )
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

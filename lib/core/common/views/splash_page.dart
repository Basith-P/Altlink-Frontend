import 'package:altlink/core/common/views/main_layout.dart';
import 'package:altlink/core/constants/strings.dart';
import 'package:altlink/core/features/user/pages/sign_up_page.dart';
import 'package:altlink/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((dur) {
      Future.delayed(const Duration(seconds: 1), () {
        final userBox = Hive.box(Strings.userBox);
        final user = userBox.get(Strings.user);
        replace(
            user != null ? MainLayout.routeName : LoginOrSignupPage.routeName);
      });
    });

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Text(
          'Altlink',
          style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

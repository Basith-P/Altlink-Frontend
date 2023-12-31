import 'package:altlink/core/config/app_router.dart';
import 'package:altlink/core/config/theme/app_theme.dart';
import 'package:altlink/core/global_keys.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Altlink',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        darkTheme: AppTheme.theme(isDark: true),
        themeMode: ThemeMode.dark,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}

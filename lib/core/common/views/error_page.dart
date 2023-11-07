import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, this.message}) : super(key: key);

  final String? message;

  static const routeName = '/error';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ErrorDisplay(message: message));
  }
}

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message ?? 'Something went wrong'));
  }
}

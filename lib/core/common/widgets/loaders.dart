import 'package:altlink/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

const loaderPrimary =
    Center(child: CircularProgressIndicator(strokeCap: StrokeCap.round));

const loaderOnButton = Center(
  child: SizedBox(
    width: 20,
    height: 20,
    child: CircularProgressIndicator(
      color: AppColors.bgDark,
      strokeWidth: 3,
      strokeCap: StrokeCap.round,
    ),
  ),
);

const loaderPrimaryPage = Scaffold(
    body: Center(child: CircularProgressIndicator(strokeCap: StrokeCap.round)));

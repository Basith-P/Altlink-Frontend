import 'package:altlink/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

const kSpacingXxs = 4.0;
const kSpacingXs = 8.0;
const kSpacingSm = 12.0;
const kSpacingMd = 16.0;
const kSpacingLg = 20.0;
const kSpacingXl = 24.0;
const kSpacing2xl = 28.0;
const kSpacing3xl = 32.0;

const kPaddingXs = EdgeInsets.all(kSpacingXs);
const kPaddingSm = EdgeInsets.all(kSpacingSm);
const kPaddingMd = EdgeInsets.all(kSpacingMd);
const kPaddingLg = EdgeInsets.all(kSpacingLg);

const kBorderRadiusXsVal = 4.0;
const kBorderRadiusSmVal = 8.0;
const kBorderRadiusMdVal = 12.0;
const kBorderRadiusLgVal = 16.0;
const kBorderRadiusXlVal = 20.0;

const kBorderRadiusSm = BorderRadius.all(Radius.circular(kBorderRadiusSmVal));
const kBorderRadiusMd = BorderRadius.all(Radius.circular(kBorderRadiusMdVal));
const kBorderRadiusLg = BorderRadius.all(Radius.circular(kBorderRadiusLgVal));
const kBorderRadiusXl = BorderRadius.all(Radius.circular(kBorderRadiusXlVal));

const kTextFieldDecorationDark = InputDecoration(
  // labelStyle: TextStyle(color: AppColors.darkGrey),
  contentPadding: EdgeInsets.symmetric(
    horizontal: kSpacingMd,
    vertical: kSpacingSm,
  ),
  // prefixIconColor: AppColors.grey,
  // hintStyle: TextStyle(color: AppColors.grey, fontWeight: FontWeight.normal),
  border: OutlineInputBorder(
    borderRadius: kBorderRadiusMd,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: kBorderRadiusMd,
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: kBorderRadiusMd,
      borderSide: BorderSide(color: AppColors.primary, width: 2.0)),
  filled: true,
  fillColor: AppColors.dark,
);

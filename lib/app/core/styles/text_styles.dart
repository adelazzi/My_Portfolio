import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/app/core/constants/fonts_family_assets_constants.dart';

import 'colors.dart';

class TextStyles {
  // Label Text Styles (Form labels, buttons, nav items)
  static TextStyle labelLarge(BuildContext context) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        fontFamily: FontsFamilyAssetsConstants.semiBold,
        color: MainColors.textColor(context),
        height: 1.4,
      );

  static TextStyle labelMedium(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        fontFamily: FontsFamilyAssetsConstants.medium,
        color: MainColors.textColor(context),
        height: 1.4,
      );

  static TextStyle labelSmall(BuildContext context) => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        fontFamily: FontsFamilyAssetsConstants.medium,
        color: MainColors.textColor(context).withValues(alpha: 0.8),
        height: 1.3,
      );
  static TextStyle labelTiny(BuildContext context) => TextStyle(
        fontSize: 6.sp,
        fontWeight: FontWeight.w700,
        fontFamily: FontsFamilyAssetsConstants.medium,
        color: MainColors.textColor(context).withValues(alpha: 0.8),
        height: 1,
      );

  // Body Text Styles (Main content, descriptions)
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontsFamilyAssetsConstants.regular,
        color: MainColors.textColor(context),
        height: 1.6,
      );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontsFamilyAssetsConstants.regular,
        color: MainColors.textColor(context),
        height: 1.5,
      );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontsFamilyAssetsConstants.regular,
        color: MainColors.textColor(context).withValues(alpha: 0.8),
        height: 1.4,
      );
  static TextStyle bodyTiny(BuildContext context) => TextStyle(
        fontSize: 6.sp,
        fontWeight: FontWeight.w400,
        fontFamily: FontsFamilyAssetsConstants.regular,
        color: MainColors.textColor(context).withValues(alpha: 0.8),
        height: 1,
      );
}

// Easy extension
extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles();
}

// Extension for easy text style access

// Usage examples in widgets:
/*
Text(
  'Hello World',
  style: TextStyles.headlineMedium(context),
),

Text(
  'Subtitle',
  style: context.textStyles.bodyMedium,
),

Text(
  'Error message',
  style: TextStyles.error(context),
),
*/

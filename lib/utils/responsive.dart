import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < ScreenSize.mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= ScreenSize.mobileBreakpoint &&
      MediaQuery.of(context).size.width < ScreenSize.tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= ScreenSize.tabletBreakpoint;

  static Widget responsiveBuilder({
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    return Builder(builder: (context) {
      if (isDesktop(context) && desktop != null) {
        return desktop;
      } else if (isTablet(context) && tablet != null) {
        return tablet;
      } else {
        return mobile;
      }
    });
  }

  static double getResponsiveFontSize(double size) {
    return size.sp;
  }

  static double getResponsiveHeight(double height) {
    return height.h;
  }

  static double getResponsiveWidth(double width) {
    return width.w;
  }

  static EdgeInsets getResponsivePadding(EdgeInsets padding) {
    return EdgeInsets.only(
      top: padding.top.h,
      bottom: padding.bottom.h,
      left: padding.left.w,
      right: padding.right.w,
    );
  }

  static SizedBox getResponsiveVerticalSpace(double height) {
    return SizedBox(height: height.h);
  }

  static SizedBox getResponsiveHorizontalSpace(double width) {
    return SizedBox(width: width.w);
  }
}

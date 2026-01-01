// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';

class ToastComponent {
  // Mobile version (full width)
  void showMobileToast(BuildContext context,
      {required String message,
      required ToastTypes type,
      double? bottomMessage}) {
    Get.snackbar(
      '', '', // Empty title
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 12.r,
      margin: EdgeInsets.only(
          bottom: bottomMessage ?? 10.r, left: 20.h, right: 20.h),
      duration: const Duration(milliseconds: 2000),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: _getBackgroundColor(type),
      isDismissible: true,
      titleText:
          const Text('', style: TextStyle(color: Colors.white, fontSize: 0)),
      boxShadows: [
        BoxShadow(
          color: MainColors.textColor(context).withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 20.r,
          offset: const Offset(0, 0),
        ),
      ],
      padding:
          EdgeInsets.only(bottom: 20.h, top: 10.h, left: 25.w, right: 25.w),
      messageText: SizedBox(
        width: Get.width - 115,
        child: Text(
          message,
          style: TextStyles.bodyTiny(context)
              .copyWith(color: MainColors.whiteColor),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  // Desktop/Window version (bottom-right corner, fixed width)
  void showDesktopToast(BuildContext context,
      {required String message, required ToastTypes type}) {
    Get.snackbar(
      '', '', // Empty title
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(
          bottom: 30.h,
          left: Get.width -
              Get.width * 0.3), // Fixed position: bottom-right corner
      borderRadius: 12.r,
      duration:
          const Duration(milliseconds: 3000), // Slightly longer for desktop
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: _getBackgroundColor(type),
      isDismissible: true,
      animationDuration: const Duration(milliseconds: 300),
      titleText:
          const Text('', style: TextStyle(color: Colors.white, fontSize: 0)),
      boxShadows: [
        BoxShadow(
          color: MainColors.textColor(context).withOpacity(0.15),
          spreadRadius: 0,
          blurRadius: 20.r,
          offset: const Offset(0, 4),
        ),
      ],

      maxWidth: Get.width * 0.25,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      // Fixed width for desktop (350 logical pixels)
      messageText: SizedBox(
        width: Get.width * 0.25,
        child: Text(
          message,
          style: TextStyles.bodyTiny(context).copyWith(
            color: MainColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Color _getBackgroundColor(ToastTypes type) {
    return type == ToastTypes.error
        ? MainColors.errorColor(Get.context!).withOpacity(0.7)
        : type == ToastTypes.success
            ? MainColors.successColor(Get.context!).withOpacity(0.7)
            : type == ToastTypes.info
                ? MainColors.primaryColor(Get.context!).withOpacity(0.7)
                : type == ToastTypes.copies
                    ? MainColors.blackColor.withOpacity(0.7)
                    : MainColors.secondaryColor(Get.context!);
  }
}

enum ToastTypes { success, error, info, warning, copies }

bool isDesktopWindow(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.width > 768; // Tablet+ breakpoint (iPad, desktop, laptop)
}

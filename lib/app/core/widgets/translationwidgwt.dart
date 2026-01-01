import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/core/utils/translation_util.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          gradient: MainColors.primaryGradient,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: MainColors.shadowColor(context),
              blurRadius: 10.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: PopupMenuButton<AppLanguage>(
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                TranslationUtil.currentLanguageDisplay,
                style: TextStyles.bodyTiny(context),
              ),
              Icon(Icons.language, size: 8.sp),
              SizedBox(width: 4.w),
            ],
          ),
          color: Theme.of(context).colorScheme.surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          elevation: 8,
          offset: Offset(0, 5.h),
          itemBuilder: (context) => TranslationUtil.supportedLocales.keys
              .map((language) => PopupMenuItem<AppLanguage>(
                    value: language,
                    child: Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 13.h),
                      decoration: BoxDecoration(
                        color: TranslationUtil.isCurrentLanguage(language)
                            ? MainColors.indicatorColor.withValues(alpha: 0.3)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        TranslationUtil.getLanguageDisplay(language),
                        style: TextStyles.labelTiny(context),
                      ),
                    ),
                  ))
              .toList(),
          onSelected: (AppLanguage language) {
            TranslationUtil.changeLanguage(language);
          },
        ),
      ),
    );
  }
}

class LanguageSwitcherMobile extends StatelessWidget {
  const LanguageSwitcherMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          gradient: MainColors.primaryGradient,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: MainColors.shadowColor(context).withValues(alpha: 0.3),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: PopupMenuButton<AppLanguage>(
          icon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // // Language name
                Flexible(
                  child: Text(
                    TranslationUtil.currentLanguageDisplay,
                    style: TextStyles.bodySmall(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(Icons.arrow_drop_down, size: 20.sp, color: Colors.white),
              ],
            ),
          ),
          // Mobile-optimized menu
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 8,
          offset: Offset(0, 48.h), // Position below button on mobile
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.85,
          ),
          itemBuilder: (context) => TranslationUtil.supportedLocales.keys
              .map((language) => PopupMenuItem<AppLanguage>(
                    value: language,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    height: 48.h, // Standard mobile touch target
                    child: Row(
                      children: [
                        // // Language name & checkmark
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  TranslationUtil.getLanguageDisplay(language),
                                  style:
                                      TextStyles.bodyMedium(context).copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              if (TranslationUtil.isCurrentLanguage(language))
                                Icon(Icons.check,
                                    size: 20.sp,
                                    color: MainColors.primaryBrand),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          onSelected: (AppLanguage language) {
            TranslationUtil.changeLanguage(language);
          },
        ),
      ),
    );
  }
}

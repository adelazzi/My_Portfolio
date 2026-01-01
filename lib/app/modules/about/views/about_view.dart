import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:my_portfolio/app/core/constants/constant_url.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/core/toast_component.dart';
import 'package:my_portfolio/app/modules/about/controllers/about_controller.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/strings_assets_constants.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);

  // Function to download and open the CV
  Future<void> _downloadCV(BuildContext context) async {
    try {
      const String cvUrl = UrlsConstants.cvUrl;
      final Uri url = Uri.parse(cvUrl);

      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (context.mounted) {
        ToastComponent().showDesktopToast(context,
            message: 'error', type: ToastTypes.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil responsive values
    final screenWidth = 1.sw;
    final isMobile = screenWidth < 768.w;
    final safePadding = 24.w;

    return Scaffold(
      backgroundColor: MainColors.backgroundColor(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          StringsAssetsConstants.aboutTitle,
          style: TextStyles.labelMedium(context)
              .copyWith(color: MainColors.primaryColor(context)),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 40.h : 100.h,
            horizontal: safePadding,
          ),
          child: Column(
            children: [
              // Hero Section with Gradient Background
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  gradient: MainColors.primaryGradient,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: MainColors.shadowColor(context),
                      blurRadius: 20.r,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Greeting & Name
                    Text(
                      StringsAssetsConstants.helloThere,
                      style: TextStyles.labelLarge(context),
                    ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.3),

                    SizedBox(height: 8.h),

                    Text(
                      StringsAssetsConstants.fullName,
                      style: TextStyles.labelMedium(context).copyWith(
                        color: MainColors.primaryColor(context),
                      ),
                    ).animate().fadeIn(duration: 1400.ms).slideY(begin: 0.4),

                    SizedBox(height: 16.h),

                    // Tagline
                    Text(
                      StringsAssetsConstants.tagline,
                      textAlign: TextAlign.center,
                      style: TextStyles.bodyTiny(context),
                    ).animate().fadeIn(duration: 1600.ms).slideY(begin: 0.5),
                  ],
                ),
              ),

              SizedBox(height: isMobile ? 40.h : 60.h),

              // Main Content Layout
              _buildDesktopContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAboutBio(context),
              SizedBox(height: 40.h),
              _buildActionButtons(context),
            ],
          ),
        ),
        SizedBox(width: 60.w),
        Expanded(
          flex: 1,
          child: _buildContactInfo(context),
        ),
      ],
    );
  }

  Widget _buildAboutBio(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsAssetsConstants.aboutQuote,
          style: TextStyles.bodySmall(context).copyWith(
            fontStyle: FontStyle.italic,
            color: MainColors.indicatorColor,
          ),
        ).animate().fadeIn(duration: 1800.ms),

        SizedBox(height: 32.h),

        // Bio Text with better typography
        Text(
          StringsAssetsConstants.aboutMe,
          style: TextStyles.bodyTiny(context),
          textAlign: TextAlign.justify,
        ).animate().fadeIn(duration: 2000.ms),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsAssetsConstants.contactTitle,
          style: TextStyles.bodySmall(context).copyWith(
            color: MainColors.primaryColor(context),
          ),
        ),
        SizedBox(height: 24.h),
        ...[
          _buildContactItem(
            context,
            Icons.email_outlined,
            StringsAssetsConstants.email,
            UrlsConstants.email,
            () => launchUrl(Uri.parse('mailto:${UrlsConstants.email}')),
          ),
          _buildContactItem(
            context,
            Icons.phone_outlined,
            StringsAssetsConstants.phoneNumber,
            UrlsConstants.phone,
            () => launchUrl(Uri.parse('tel:${UrlsConstants.phone}')),
          ),
          _buildContactItem(
            context,
            Icons.location_on_outlined,
            StringsAssetsConstants.locationString,
            StringsAssetsConstants.location,
            null,
          ),
          _buildContactItem(
            context,
            Bootstrap.github,
            'github',
            'https://github.com/adelazzi',
            () => launchUrl(Uri.parse('https://github.com/adelazzi')),
          ),
        ],
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback? onTap,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: MainColors.backgroundColor(context),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child:
                      Icon(icon, color: MainColors.indicatorColor, size: 10.sp),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: TextStyles.bodyTiny(context)),
                      SizedBox(height: 4.h),
                      Text(
                        value,
                        style: TextStyles.bodyTiny(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Primary CTA
        ElevatedButton.icon(
          onPressed: () => _downloadCV(context),
          icon: Icon(Icons.download, size: 10.sp),
          label: Text(
            StringsAssetsConstants.downloadCVCTA,
            style: TextStyles.labelTiny(context)
                .copyWith(color: MainColors.backgroundColor(context)),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12.r),
            elevation: 0,
            shadowColor: MainColors.shadowColor(context),
            backgroundColor: MainColors.primaryColor(context),
            foregroundColor: MainColors.backgroundColor(context),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
          ),
        ).animate().fadeIn(duration: 2200.ms).scale(delay: 200.ms),

        // Secondary CTA
        OutlinedButton.icon(
          onPressed: () {
            Get.find<MainpageController>().changePage(4);
          },
          icon: Icon(Icons.visibility, size: 10.sp),
          label: Text(
            StringsAssetsConstants.viewWorkCTA,
            style: TextStyles.labelTiny(context),
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.all(12.r),
            elevation: 0,
            side:
                BorderSide(color: MainColors.primaryColor(context), width: 1.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
          ),
        ).animate().fadeIn(duration: 2400.ms).scale(delay: 400.ms),
      ],
    );
  }
}

class AboutViewMobile extends GetView<AboutController> {
  const AboutViewMobile({Key? key}) : super(key: key);

  Future<void> _downloadCV(BuildContext context) async {
    try {
      const String cvUrl = UrlsConstants.cvUrl;
      final Uri url = Uri.parse(cvUrl);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (context.mounted) {
        ToastComponent().showMobileToast(context,
            message: 'خطأ في التحميل', type: ToastTypes.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Hero Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.h),
            margin: EdgeInsets.only(bottom: 32.h),
            decoration: BoxDecoration(
              gradient: MainColors.primaryGradient,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: MainColors.shadowColor(context),
                  blurRadius: 25.r,
                  offset: Offset(0, 8.h),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(StringsAssetsConstants.helloThere,
                    style: TextStyles.bodyLarge(context)),
                SizedBox(height: 12.h),
                Text(StringsAssetsConstants.fullName,
                    style: TextStyles.labelMedium(context)
                        .copyWith(color: MainColors.primaryColor(context))),
                SizedBox(height: 16.h),
                Text(StringsAssetsConstants.tagline,
                    textAlign: TextAlign.center,
                    style: TextStyles.bodyLarge(context)),
              ],
            ),
          ),

          // About Bio - Full width
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: MainColors.backgroundColor(context).withOpacity(0.5),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                  color: MainColors.primaryColor(context).withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringsAssetsConstants.aboutQuote,
                    style: TextStyles.bodyLarge(context).copyWith(
                        fontStyle: FontStyle.italic,
                        color: MainColors.primaryColor(context))),
                SizedBox(height: 20.h),
                Text(StringsAssetsConstants.aboutMe,
                    style: TextStyles.bodyMedium(context),
                    textAlign: TextAlign.start),
              ],
            ),
          ),

          SizedBox(height: 40.h),

          // Action Buttons - Stacked
          Column(
            children: [
              // Download CV - Primary
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _downloadCV(context),
                  icon: Icon(Icons.download, size: 20.sp),
                  label: Text(
                    StringsAssetsConstants.downloadCVCTA,
                    style: TextStyles.bodyMedium(context).copyWith(
                      color: MainColors.backgroundColor(context),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    backgroundColor: MainColors.primaryColor(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r)),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),

          SizedBox(height: 32.h),

          // Contact Info - Cards
          Text(StringsAssetsConstants.contactTitle,
              style: TextStyles.labelMedium(context)
                  .copyWith(color: MainColors.primaryColor(context))),
          SizedBox(height: 24.h),
          Column(
            children: [
              _buildContactCard(context, Icons.email_outlined,
                  StringsAssetsConstants.email, UrlsConstants.email),
              SizedBox(height: 16.h),
              _buildContactCard(context, Icons.phone_outlined,
                  StringsAssetsConstants.phoneNumber, UrlsConstants.phone),
              SizedBox(height: 16.h),
              _buildContactCard(
                  context,
                  Icons.location_on_outlined,
                  StringsAssetsConstants.locationString,
                  StringsAssetsConstants.location),
              SizedBox(height: 16.h),
              _buildContactCard(
                  context, Icons.code, 'GitHub', 'https://github.com/adelazzi',
                  isLink: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
      BuildContext context, IconData icon, String label, String value,
      {bool isLink = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
            color: MainColors.primaryColor(context).withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10.r),
        ],
      ),
      child: InkWell(
        onTap: isLink ? () => launchUrl(Uri.parse(value)) : null,
        borderRadius: BorderRadius.circular(16.r),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: MainColors.primaryColor(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon,
                  color: MainColors.primaryColor(context), size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyles.bodySmall(context)
                          .copyWith(fontWeight: FontWeight.w500)),
                  SizedBox(height: 4.h),
                  Text(value, style: TextStyles.bodyMedium(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

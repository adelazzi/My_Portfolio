// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/core/toast_component.dart';
import 'package:my_portfolio/app/core/utils/portfolio_data.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';
import 'package:my_portfolio/app/modules/education/controllers/education_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class EducationView extends StatelessWidget {
  EducationView({Key? key}) : super(key: key);
  final EducationController controller = Get.put(EducationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.backgroundColor(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          StringsAssetsConstants.education,
          style: TextStyles.labelSmall(context)
              .copyWith(color: MainColors.primaryColor(context)),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: controller.loadEducationData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section Title - ANIMATED
                Text(
                  StringsAssetsConstants.educationJourney,
                  style: TextStyles.bodyTiny(context),
                ).animate().fadeIn(duration: 2000.ms),
                SizedBox(height: 24.h),

                // Intro Text - ANIMATED
                Text(
                  StringsAssetsConstants.educationIntro,
                  style: TextStyles.bodyTiny(context),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 2000.ms, delay: 300.ms),
                SizedBox(height: 40.h),

                // Education Timeline - ANIMATED
                Column(
                  children: PortfolioData.educationList
                      .asMap()
                      .entries
                      .map((entry) => EducationCardWidget(
                            key:
                                ValueKey(entry.key), // Unique key for animation
                            education: entry.value,
                          ).animate().fadeIn(
                                duration: 2000.ms,
                                delay:
                                    (entry.key * 200).ms, // Staggered animation
                              ))
                      .toList(),
                ),

                SizedBox(height: 48.h),

                // Certifications Section - ANIMATED
                Text(
                  StringsAssetsConstants.certifications,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 2000.ms, delay: 500.ms),
                SizedBox(height: 24.h),

                // Certifications Grid
                _buildCertificationsGrid(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCertificationsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200
            ? 3
            : constraints.maxWidth > 768
                ? 2
                : 1;

        return Obx(() => GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 2,
                crossAxisSpacing: 18.w,
                mainAxisSpacing: 18.h,
              ),
              children: [
                CertificationCard(
                        titel: StringsAssetsConstants.licensedComputerScientist,
                        certification: controller.certifications[0])
                    .animate()
                    .fadeIn(duration: 2000.ms),
                CertificationCard(
                        titel: StringsAssetsConstants.valteerArabGames,
                        certification: controller.certifications[1])
                    .animate()
                    .fadeIn(duration: 2000.ms, delay: 150.ms),
                CertificationCard(
                        titel: StringsAssetsConstants.hoskaDevTraining,
                        certification: controller.certifications[2])
                    .animate()
                    .fadeIn(duration: 2000.ms, delay: 300.ms),
              ],
            ));
      },
    );
  }
}

// Fixed typo in CertificationCard
class CertificationCard extends StatelessWidget {
  final Certafication certification; // Fixed: Certafication -> Certification

  String titel;
  CertificationCard(
      {Key? key, required this.titel, required this.certification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: MainColors.primaryGradient,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => _launchCertificate(context),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  color: MainColors.backgroundColor(context).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified,
                  size: 15.sp,
                  color: MainColors.whiteColor,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                titel,
                style: TextStyles.labelTiny(context),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8.h),
              Text(
                '${certification.issuer} • ${certification.date}',
                style: TextStyles.bodyTiny(context),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchCertificate(BuildContext context) async {
    final uri = Uri.parse(certification.credential);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ToastComponent().showDesktopToast(context,
            message: StringsAssetsConstants.openCertificateError,
            type: ToastTypes.error);
      }
    }
  }
}

class EducationCardWidget extends StatelessWidget {
  final Education education;

  const EducationCardWidget({Key? key, required this.education})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(10.w), // Increased padding for better spacing
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo Placeholder - ANIMATED
            Container(
              width: 28.w,
              height: 28.w,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: MainColors.primaryColor(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: education.logoUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                      child: Image.asset(
                        education.logoUrl!,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.contain,
                      ),
                    )
                  : Icon(
                      Icons.school,
                      size: 28.sp, // Larger icon
                      color: MainColors.primaryColor(context),
                    ),
            ),
            SizedBox(width: 20.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Degree Title
                  Text(
                    education.degree,
                    style: TextStyles.labelTiny(context),
                  ),
                  SizedBox(height: 8.h),

                  // Institution
                  Text(
                    education.institution,
                    style: TextStyles.bodyTiny(context),
                  ),
                  SizedBox(height: 4.h),

                  // Period
                  Text(
                    education.period,
                    style: TextStyles.bodyTiny(context).copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Description
                  Text(
                    education.description,
                    style: TextStyles.bodyTiny(context).copyWith(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(); // Animation already handled by parent
  }
}

class EducationViewMobile extends StatelessWidget {
  EducationViewMobile({Key? key}) : super(key: key);
  final EducationController controller = Get.put(EducationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.loadEducationData,
          child: ListView(
            shrinkWrap: true, // ✅ Fix 1: Fit parent height

            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              // Title
              Text(
                StringsAssetsConstants.educationJourney,
                style: TextStyles.bodyMedium(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),

              // Intro
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  StringsAssetsConstants.educationIntro,
                  style: TextStyles.bodyMedium(context),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32.h),

              // Education Cards (Stacked - full width)
              ...PortfolioData.educationList.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: EducationCardWidgetMobile(education: entry.value),
                );
              }),

              SizedBox(height: 40.h),

              // Certifications Title
              Text(
                StringsAssetsConstants.certifications,
                style: TextStyles.labelMedium(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),

              // Certifications (Single column for mobile)

              ...controller.certifications.asMap().entries.map((entry) {
                final index = entry.key;
                final cert = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CertificationCardMobile(
                    titel: index == 0
                        ? StringsAssetsConstants.licensedComputerScientist
                        : index == 1
                            ? StringsAssetsConstants.valteerArabGames
                            : StringsAssetsConstants.hoskaDevTraining,
                    certification: cert,
                  ),
                );
              }).toList(),
              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
    );
  }
}

class CertificationCardMobile extends StatelessWidget {
  final Certafication certification;
  final String titel;

  const CertificationCardMobile(
      {Key? key, required this.titel, required this.certification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ Full width for mobile
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: MainColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context),
            blurRadius: 15.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () => _launchCertificate(context),
          child: Padding(
            padding: EdgeInsets.all(20.w), // Larger padding
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified,
                    size: 28.sp, // Bigger icon
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  titel,
                  style: TextStyles.bodyLarge(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 12.h),
                Text(
                  '${certification.issuer} • ${certification.date}',
                  style: TextStyles.bodyMedium(context).copyWith(
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchCertificate(BuildContext context) async {
    final uri = Uri.parse(certification.credential);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ToastComponent().showMobileToast(Get.context!,
          message: StringsAssetsConstants.openCertificateError,
          type: ToastTypes.error);
    }
  }
}

class EducationCardWidgetMobile extends StatelessWidget {
  final Education education;

  const EducationCardWidgetMobile({Key? key, required this.education})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // ✅ Full width
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(20.w), // Larger padding
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
            color: MainColors.primaryColor(context).withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo at top center
          Center(
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: MainColors.primaryColor(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: education.logoUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child:
                          Image.asset(education.logoUrl!, fit: BoxFit.contain),
                    )
                  : Icon(Icons.school,
                      size: 32.sp, color: MainColors.primaryColor(context)),
            ),
          ),
          SizedBox(height: 20.h),

          // Content stacked vertically
          Text(
            education.degree,
            style: TextStyles.labelSmall(context),
          ),
          SizedBox(height: 8.h),
          Text(
            education.institution,
            style: TextStyles.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4.h),
          Text(
            education.period,
            style: TextStyles.bodyMedium(context).copyWith(color: Colors.grey),
          ),
          SizedBox(height: 16.h),
          Text(
            education.description,
            style: TextStyles.bodyMedium(context),
          ),
        ],
      ),
    );
  }
}

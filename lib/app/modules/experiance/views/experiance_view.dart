// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/core/utils/portfolio_data.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';
import 'package:my_portfolio/app/modules/experiance/controllers/experiance_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExperianceView extends StatelessWidget {
  ExperianceView({Key? key}) : super(key: key);
  ExperianceController controller = Get.put(ExperianceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.backgroundColor(context),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          StringsAssetsConstants.experienceTitle,
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
          onRefresh: controller.loadExperienceData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section Title
                Text(
                  StringsAssetsConstants.experienceJourney,
                  style: TextStyles.labelSmall(context),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 2000.ms),
                SizedBox(height: 24.h),

                // Intro Text
                Text(
                  StringsAssetsConstants.experienceIntro,
                  style: TextStyles.bodyTiny(context),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 2000.ms, delay: 300.ms),
                SizedBox(height: 48.h),

                // Professional Experience
                ...PortfolioData.experienceList.asMap().entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 32.h),
                    child: ExperienceCardWidget(
                      key: ValueKey('exp_${entry.key}'),
                      experience: entry.value,
                    ).animate().fadeIn(
                          duration: 2000.ms,
                          delay: (entry.key * 200).ms,
                        ),
                  );
                }),

                SizedBox(height: 48.h),

                // University Club Activities Section
                Text(
                  StringsAssetsConstants.clubActivitiesTitle,
                  style: TextStyles.bodyTiny(context),
                ).animate().fadeIn(duration: 2000.ms, delay: 500.ms),
                SizedBox(height: 12.h),
                Divider(height: 1.h),
                SizedBox(height: 24.h),

                // Club Activities
                ...PortfolioData.clubActivities.asMap().entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 32.h),
                    child: ClubActivityCard(
                      key: ValueKey('club_${entry.key}'),
                      clubActivity: entry.value,
                    ).animate().fadeIn(
                          duration: 2000.ms,
                          delay: (entry.key * 200 + 400).ms,
                        ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ExperienceCardWidget extends StatelessWidget {
  final Experience experience;

  const ExperienceCardWidget({Key? key, required this.experience})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MainColors.primaryColor(context).withOpacity(0.05),
            MainColors.primaryColor(context).withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: MainColors.primaryColor(context).withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: MainColors.primaryColor(context).withOpacity(0.1),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern Logo Container
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                gradient: MainColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: MainColors.primaryColor(context).withOpacity(0.3),
                    blurRadius: 16.r,
                    offset: Offset(0, 6.h),
                  ),
                ],
              ),
              child: experience.logoUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(36.r),
                      child: Image.network(
                        experience.logoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.work, size: 28.sp, color: Colors.white),
                      ),
                    )
                  : Icon(Icons.work, size: 28.sp, color: Colors.white),
            ),
            SizedBox(width: 20.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Position with badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          experience.position,
                          style: TextStyles.labelTiny(context),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: MainColors.primaryColor(context),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          StringsAssetsConstants.fullTime,
                          style: TextStyle(
                            color: MainColors.backgroundColor(context),
                            fontSize: 5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),

                  // Company & Period
                  Row(
                    children: [
                      Icon(Icons.business,
                          size: 14.sp, color: Colors.grey[600]),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          experience.company,
                          style: TextStyles.bodyTiny(context),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        experience.period,
                        style: TextStyles.bodyTiny(context).copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Description
                  Text(
                    experience.description,
                    style: TextStyles.bodyTiny(context).copyWith(
                      height: 1.4,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClubActivityCard extends StatelessWidget {
  final ClubActivity clubActivity;

  const ClubActivityCard({Key? key, required this.clubActivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.04),
            Colors.blue.withOpacity(0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.blue.withOpacity(0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 16.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                // Activity Icon
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: clubActivity.logoUrl!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(clubActivity.logoUrl!))
                      : Icon(
                          Icons.group,
                          size: 15.sp,
                          color: Colors.white,
                        ),
                ),
                SizedBox(width: 16.w),

                // Title & Role
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clubActivity.name,
                        style: TextStyles.bodyTiny(context),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: MainColors.accentBrand.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              color: MainColors.accentBrand.withOpacity(0.4)),
                        ),
                        child: Text(
                          clubActivity.role,
                          style: TextStyles.bodyTiny(context),
                        ),
                      ),
                    ],
                  ),
                ),
                // Period Badge
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: MainColors.primaryBrand.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                        color: MainColors.primaryBrand.withOpacity(0.3)),
                  ),
                  child: Text(
                    clubActivity.period,
                    style: TextStyles.labelTiny(context)
                        .copyWith(color: MainColors.indicatorColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Description
            Text(
              clubActivity.description,
              style: TextStyles.bodyTiny(context).copyWith(
                height: 1.4,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12.h),

            // Achievements Chips (Creative!)
            if (clubActivity.achievements != null &&
                clubActivity.achievements!.isNotEmpty)
              Wrap(
                spacing: 8.w,
                runSpacing: 6.h,
                children: clubActivity.achievements!
                    .take(3)
                    .map((achievement) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: MainColors.inactiveColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                                color:
                                    MainColors.inactiveColor.withOpacity(0.2)),
                          ),
                          child: Text(
                            achievement,
                            style: TextStyles.bodyTiny(context).copyWith(
                              color: MainColors.inactiveColor,
                            ),
                          ),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class ExperianceViewMobile extends StatelessWidget {
  ExperianceViewMobile({Key? key}) : super(key: key);
  final ExperianceController controller = Get.put(ExperianceController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.loadExperienceData,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Title
              Text(
                StringsAssetsConstants.experienceJourney,
                style: TextStyles.labelSmall(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),

              // Intro
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  StringsAssetsConstants.experienceIntro,
                  style: TextStyles.bodyLarge(context),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32.h),

              // Professional Experience (Full width stacked)
              Text(
                'Professional Experience',
                style: TextStyles.labelMedium(context),
              ),
              SizedBox(height: 16.h),
              ...PortfolioData.experienceList.map((experience) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: ExperienceCardWidgetMobile(experience: experience),
                );
              }),

              SizedBox(height: 40.h),

              // Club Activities Section
              Text(
                StringsAssetsConstants.clubActivitiesTitle,
                style: TextStyles.labelMedium(context),
              ),
              SizedBox(height: 12.h),
              const Divider(),
              SizedBox(height: 20.h),

              // Club Activities (Full width stacked)
              ...PortfolioData.clubActivities.map((activity) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: ClubActivityCardMobile(clubActivity: activity),
                );
              }),

              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
    );
  }
}

class ExperienceCardWidgetMobile extends StatelessWidget {
  final Experience experience;
  const ExperienceCardWidgetMobile({Key? key, required this.experience})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MainColors.primaryColor(context).withOpacity(0.08),
            MainColors.primaryColor(context).withOpacity(0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
            color: MainColors.primaryColor(context).withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: MainColors.primaryColor(context).withOpacity(0.15),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo at top center
          Center(
            child: Container(
                width: 70.w,
                height: 70.w,
                decoration: const BoxDecoration(
                  gradient: MainColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child:
                    // experience.logoUrl!.isEmpty
                    //     ?
                    ClipRRect(
                  borderRadius: BorderRadius.circular(35.r),
                  child: Image.asset(experience.logoUrl!, fit: BoxFit.cover),
                )
                // : Icon(Icons.work, size: 35.sp, color: Colors.white),
                ),
          ),
          SizedBox(height: 20.h),

          // Position
          Text(
            experience.position,
            style: TextStyles.labelSmall(context),
          ),
          SizedBox(height: 8.h),

          // Company & Period Row
          Row(
            children: [
              Icon(Icons.business, size: 20.sp, color: Colors.grey[600]),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  experience.company,
                  style: TextStyles.bodyLarge(context),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: MainColors.primaryColor(context),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  StringsAssetsConstants.fullTime,
                  style: TextStyles.bodySmall(context)
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Description
          Text(
            experience.description,
            style: TextStyles.bodyMedium(context),
          ),
        ],
      ),
    );
  }
}

class ClubActivityCardMobile extends StatelessWidget {
  final ClubActivity clubActivity;
  const ClubActivityCardMobile({Key? key, required this.clubActivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.08),
            Colors.blue.withOpacity(0.08)
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.15),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.purple, Colors.blue]),
                  shape: BoxShape.circle,
                ),
                child: clubActivity.logoUrl!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        child: Image.asset(clubActivity.logoUrl!))
                    : Icon(Icons.group, size: 30.sp, color: Colors.white),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(clubActivity.name,
                        style: TextStyles.labelSmall(context)),
                    SizedBox(height: 4.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: MainColors.accentBrand.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(clubActivity.role,
                          style: TextStyles.bodySmall(context)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: MainColors.primaryBrand.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(clubActivity.period,
                    style: TextStyles.bodySmall(context)),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Description
          Text(clubActivity.description, style: TextStyles.bodyMedium(context)),
          SizedBox(height: 16.h),

          // Achievements (Wrap for mobile)
          if (clubActivity.achievements != null &&
              clubActivity.achievements!.isNotEmpty)
            Wrap(
              spacing: 12.w,
              runSpacing: 8.h,
              children: clubActivity.achievements!
                  .take(3)
                  .map((achievement) => Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: MainColors.inactiveColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(achievement,
                            style: TextStyles.bodySmall(context)),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  Future<void> _launchUrl(String? url) async {
    if (url != null && url.isNotEmpty) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar('Error', 'Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.r),
      width: double.infinity,
      height: 310.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: MainColors.whiteColor.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context),
            spreadRadius: 5.r,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.w,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: () {
          Get.dialog(
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AlertDialog(
                backgroundColor:
                    MainColors.backgroundColor(context).withOpacity(0.8),
                title: Text(
                  project.title,
                  style: TextStyles.bodyMedium(context),
                ),
                content: Text(
                  project.description,
                  style: TextStyles.bodySmall(context),
                ),
              ),
            ),
          );
        },

        // _launchUrl(project.liveUrl ?? project.githubUrl),
        // onHover: (hovered) {}, // No animation

        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Container
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.dialog(
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: AlertDialog(
                          backgroundColor: MainColors.backgroundColor(context)
                              .withOpacity(0.8),
                          content: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              project.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.image_not_supported, size: 28.sp),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.grey[900],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        project.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported, size: 28.sp),
                      ),
                    ),
                  ),
                ),
              ),
              //
              SizedBox(
                width: 5.w,
              ),
              // Content Column - NO Spacer()
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      project.title,
                      style: TextStyles.labelTiny(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      project.description,
                      style: TextStyles.bodyTiny(context).copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 4.h,
                      children: project.technologies
                          .map((tech) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 0.5.w,
                                  ),
                                ),
                                child: Text(
                                  tech,
                                  style: TextStyles.bodyTiny(context).copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 8.h), // Fixed spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (project.githubUrl != null)
                          IconButton(
                            onPressed: () => _launchUrl(project.githubUrl),
                            icon: Icon(Icons.code,
                                color: Colors.white, size: 16.sp),
                            tooltip: 'GitHub',
                            padding: EdgeInsets.all(4.w),
                            constraints: const BoxConstraints(),
                          ),
                        if (project.liveUrl != null)
                          IconButton(
                            onPressed: () => _launchUrl(project.liveUrl),
                            icon: Icon(Icons.launch,
                                color: Colors.white, size: 16.sp),
                            tooltip: 'Live Demo',
                            padding: EdgeInsets.all(4.w),
                            constraints: const BoxConstraints(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCardMobile extends StatelessWidget {
  final Project project;

  const ProjectCardMobile({Key? key, required this.project}) : super(key: key);

  Future<void> _launchUrl(String? url) async {
    if (url != null && url.isNotEmpty) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar('Error', 'Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      width: double.infinity,
      height: 200.h, // Reduced height for mobile
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: MainColors.whiteColor.withOpacity(0.15),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context).withOpacity(0.3),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1.w,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => _showProjectDialog(context),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image - smaller for mobile
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    width: 80.w,
                    height: 80.h,
                    child: Image.network(
                      project.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[900],
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.white54,
                          size: 32.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Content - takes remaining space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        project.title,
                        style: TextStyles.bodyLarge(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      // Description
                      Text(
                        project.description,
                        style: TextStyles.bodyMedium(context).copyWith(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13.sp,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      // Technologies - smaller chips
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 4.h,
                        children: project.technologies
                            .take(3) // Limit to 3 tags on mobile
                            .map((tech) => Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 0.5.w,
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style:
                                        TextStyles.bodySmall(context).copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      const Spacer(),
                      // Action buttons - aligned to bottom right
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (project.githubUrl != null) ...[
                            IconButton(
                              onPressed: () => _launchUrl(project.githubUrl),
                              icon: Icon(Icons.code,
                                  color: Colors.white, size: 20.sp),
                              padding: EdgeInsets.all(4.w),
                              constraints: BoxConstraints(
                                minWidth: 32.w,
                                minHeight: 32.h,
                              ),
                              tooltip: 'GitHub',
                            ),
                          ],
                          if (project.liveUrl != null)
                            IconButton(
                              onPressed: () => _launchUrl(project.liveUrl),
                              icon: Icon(Icons.launch,
                                  color: Colors.white, size: 20.sp),
                              padding: EdgeInsets.all(4.w),
                              constraints: BoxConstraints(
                                minWidth: 32.w,
                                minHeight: 32.h,
                              ),
                              tooltip: 'Live Demo',
                            ),
                        ],
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

  void _showProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: MainColors.backgroundColor(context),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Container(
          padding: EdgeInsets.all(20.w),
          constraints: BoxConstraints(maxHeight: 400.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: TextStyles.labelSmall(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.description,
                        style: TextStyles.bodyMedium(context).copyWith(
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      if (project.technologies.isNotEmpty) ...[
                        Text(
                          'Technologies:',
                          style: TextStyles.bodyLarge(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 6.h,
                          children: project.technologies
                              .map((tech) => Chip(
                                    label: Text(
                                      tech,
                                      style: TextStyles.bodySmall(context)
                                          .copyWith(color: Colors.white),
                                    ),
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    side: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('Close',
                        style: TextStyles.bodyMedium(context)
                            .copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

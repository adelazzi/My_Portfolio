// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/core/utils/portfolio_data.dart';
import 'package:my_portfolio/app/core/widgets/projectcard.dart';
import 'package:my_portfolio/app/modules/projects/controllers/projects_controller.dart';

class ProjectsView extends GetView<ProjectsController> {
  ProjectsView({Key? key}) : super(key: key);
  ProjectsController controller = Get.put(ProjectsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'projects',
          style: TextStyles.labelLarge(context)
              .copyWith(color: MainColors.primaryColor(context)),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (PortfolioData.projectList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.work_off, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No projects available',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: PortfolioData.projectList.length,
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemBuilder: (context, index) {
              final project = PortfolioData.projectList[index];
              return ProjectCard(project: project);
            },
          ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.3),
        );
      }),
    );
  }
}



class ProjectsViewMobile extends GetView<ProjectsController> {
  ProjectsViewMobile({Key? key}) : super(key: key);
  final ProjectsController controller = Get.put(ProjectsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          // Title (no AppBar for parent navigation)
          Text(
            'Projects',
            style: TextStyles.labelMedium(context).copyWith(
              color: MainColors.primaryColor(context),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),

          Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
          
            if (PortfolioData.projectList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.work_off, size: 100.sp, color: Colors.grey[400]),
                    SizedBox(height: 24.h),
                    Text(
                      'No projects available yet',
                      style: TextStyles.labelMedium(context).copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }
          
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: PortfolioData.projectList.length,
              separatorBuilder: (context, index) => SizedBox(height: 24.h),
              itemBuilder: (context, index) {
                final project = PortfolioData.projectList[index];
                return ProjectCardMobile(project: project);
              },
            );
          }),
        ],
      ),
    );
  }
}

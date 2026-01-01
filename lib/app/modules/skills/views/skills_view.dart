// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/core/utils/portfolio_data.dart';
import 'package:my_portfolio/app/core/widgets/skillcard.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';
import 'package:my_portfolio/app/modules/skills/controllers/skills_controller.dart';

class SkillsView extends GetView<SkillsController> {
  const SkillsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'skills',
          style: TextStyles.labelSmall(context)
              .copyWith(color: MainColors.primaryColor(context)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Groups
              _buildCategoryGroup(
                      'Frontend Development',
                      PortfolioData.skillsList
                          .where((s) => s.category == 'Frontend')
                          .toList(),
                      Colors.blue)
                  .animate()
                  .fadeIn(duration: 1200.ms)
                  .slideY(begin: 0.3),
              SizedBox(height: 32.h),
              _buildCategoryGroup(
                      'Backend Development',
                      PortfolioData.skillsList
                          .where((s) => s.category == 'Backend')
                          .toList(),
                      Colors.red)
                  .animate()
                  .fadeIn(duration: 1200.ms)
                  .slideY(begin: 0.3),
              SizedBox(height: 32.h),
              _buildCategoryGroup(
                'Data Bases',
                PortfolioData.skillsList
                    .where((s) => s.category == 'Database')
                    .toList(),
                MainColors.accentBrand,
              ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.3),
              SizedBox(height: 32.h),
              _buildCategoryGroup(
                'DevOps',
                PortfolioData.skillsList
                    .where((s) => s.category == 'DevOps')
                    .toList(),
                MainColors.inactiveColor,
              ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryGroup(
      String category, List<Skill> skills, Color? skillcolor) {
    if (skills.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                skillcolor!.withValues(alpha: 0.2),
                Colors.transparent,
              ],
            ),
            borderRadius: BorderRadius.circular(8.r),
            border: Border(
                left: BorderSide(
                    color: skillcolor.withValues(alpha: 0.2), width: 3.w)),
          ),
          child: Row(
            children: [
              Icon(Icons.category,
                  size: 8.sp, color: Colors.white.withValues(alpha: 0.9)),
              SizedBox(width: 8.w),
              Text(
                category,
                style: TextStyles.labelSmall(Get.context!),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Skills Tilesconst  Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 768 ? 3 : 2;
            return GridView.count(
              shrinkWrap: true,
              // ignore: prefer_const_constructors
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 2.4,
              children: skills
                  .map((skill) => SkillTile(
                        skill: skill,
                        color: skillcolor,
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class SkillsViewMobile extends StatelessWidget {
  const SkillsViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('images/project_background.png'),
      )),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Important for ListView
        children: [
          // Skills Section Header (optional)
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              children: [
                Icon(Icons.star,
                    size: 20.sp, color: MainColors.primaryColor(context)),
                SizedBox(width: 8.w),
                Text(
                  'Skills',
                  style: TextStyles.labelSmall(context).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Category Groups
          _buildCategoryGroup(
            'Frontend Development',
            PortfolioData.skillsList
                .where((s) => s.category == 'Frontend')
                .toList(),
            Colors.blue,
          ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.3),
          SizedBox(height: 20.h),
          _buildCategoryGroup(
            'Backend Development',
            PortfolioData.skillsList
                .where((s) => s.category == 'Backend')
                .toList(),
            Colors.red,
          ).animate().fadeIn(duration: 1400.ms).slideY(begin: 0.3),
          SizedBox(height: 20.h),
          _buildCategoryGroup(
            'Data Bases',
            PortfolioData.skillsList
                .where((s) => s.category == 'Database')
                .toList(),
            MainColors.accentBrand,
          ).animate().fadeIn(duration: 1600.ms).slideY(begin: 0.3),
          SizedBox(height: 20.h),
          _buildCategoryGroup(
            'DevOps',
            PortfolioData.skillsList
                .where((s) => s.category == 'DevOps')
                .toList(),
            MainColors.inactiveColor,
          ).animate().fadeIn(duration: 1800.ms).slideY(begin: 0.3),
          SizedBox(height: 8.h), // Bottom padding for ListView
        ],
      ),
    );
  }

  Widget _buildCategoryGroup(
      String category, List<Skill> skills, Color? skillcolor) {
    if (skills.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Compact Category Header for ListView
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [skillcolor!.withValues(alpha: 0.12), Colors.transparent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.r),
            border: Border(
              left: BorderSide(
                  color: skillcolor.withValues(alpha: 0.3), width: 3.w),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: skillcolor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  _getCategoryIcon(category),
                  size: 14.sp,
                  color: skillcolor,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  category,
                  style: TextStyles.labelMedium(Get.context!).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Skills List - Perfect for ListView container
        ...skills
            .map((skill) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: SkillTile(skill: skill, color: skillcolor),
                ))
            .toList(),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Frontend Development':
        return Icons.code;
      case 'Backend Development':
        return Icons.dataset;
      case 'Data Bases':
        return Icons.storage;
      case 'DevOps':
        return Icons.build;
      default:
        return Icons.category;
    }
  }
}

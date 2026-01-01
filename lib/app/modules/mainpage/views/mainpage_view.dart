// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/app/core/constants/icons_assets_constants.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/core/widgets/translationwidgwt.dart';
import 'package:my_portfolio/app/modules/about/views/about_view.dart';
import 'package:my_portfolio/app/modules/contact/views/contact_view.dart';
import 'package:my_portfolio/app/modules/education/views/education_view.dart';
import 'package:my_portfolio/app/modules/experiance/views/experiance_view.dart';
import 'package:my_portfolio/app/modules/home/views/home_view.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:my_portfolio/app/modules/projects/views/projects_view.dart';
import 'package:my_portfolio/app/modules/skills/views/skills_view.dart';

class MainpageView extends GetView<MainpageController> {
  const MainpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 768;

    return isDesktop
        ? Scaffold(
            body: Row(
              children: [
                // ✅ FIXED: Responsive Sidebar (300px desktop, 85% mobile)
                Container(
                    width: Get.width * 0.25,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          MainColors.primaryColor(context)
                              .withValues(alpha: 0.1),
                          Colors.transparent,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(4, 0),
                        ),
                      ],
                    ),
                    child: Stack(children: [
                      Align(
                        alignment: AlignmentGeometry.bottomCenter,
                        child: SizedBox(
                            height: 60.w,
                            child: Lottie.asset(IconsAssetsConstants.robot)),
                      ),
                      SizedBox(
                        height: double.infinity,
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            // ✅ FIXED: Profile Header with proper sizing
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    StringsAssetsConstants.fullName,
                                    style: TextStyles.labelTiny(context),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(30.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          blurRadius: 15.r,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const LanguageSwitcher(),
                                  ),
                                ],
                              ),
                            ),

                            // Navigation Menu
                            Expanded(
                                child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: _buildNavItems(context))),
                          ],
                        ),
                      ),
                    ])),

                // ✅ UNCOMMENT & FIXED: Main Content Area
                Expanded(child: _buildDynamicContent()),
              ],
            ),
          )
        : Scaffold(
            floatingActionButton: const LanguageSwitcherMobile(),
            body: ListView(
              children: [
                HomeViewMobile()
                    .animate()
                    .fadeIn(duration: 800.ms, curve: Curves.easeOutBack)
                    .slideY(
                        begin: 0.4,
                        duration: 800.ms,
                        curve: Curves.easeOutBack),
                _buildAnimatedSection(
                    child: const AboutViewMobile(),
                    delay: 200.ms,
                    duration: 600.ms),
                _buildAnimatedSection(
                    child: EducationViewMobile(),
                    delay: 400.ms,
                    duration: 600.ms),
                _buildAnimatedSection(
                    child: ExperianceViewMobile(),
                    delay: 600.ms,
                    duration: 600.ms),
                _buildAnimatedSection(
                    child: ProjectsViewMobile(),
                    delay: 800.ms,
                    duration: 700.ms),
                _buildAnimatedSection(
                    child: const SkillsViewMobile(),
                    delay: 1100.ms,
                    duration: 700.ms),
                _buildAnimatedSection(
                    child: ContactViewMobile(),
                    delay: 1400.ms,
                    duration: 800.ms),
              ],
            ),
          );
  }

  Widget _buildAnimatedSection({
    required Widget child,
    required Duration delay,
    required Duration duration,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: child
          .animate(
            delay: delay,
            onPlay: (controller) => controller.forward(),
          )
          .fadeIn(
            duration: duration,
            curve: Curves.easeOutCubic,
          )
          .slideY(
            begin: 0.3,
            end: 0,
            duration: duration,
            curve: Curves.easeOutCubic,
          )
          .scale(
            begin: const Offset(0.92, 0.92),
            end: const Offset(1.0, 1.0),
            duration: duration * 0.8,
            curve: Curves.easeOutBack,
          ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context) {
    return [
      _buildNavItem(context, 0, StringsAssetsConstants.home, Icons.home),
      _buildNavItem(context, 1, StringsAssetsConstants.about, Icons.person),
      _buildNavItem(context, 2, StringsAssetsConstants.education, Icons.school),
      _buildNavItem(context, 3, StringsAssetsConstants.experience, Icons.work),
      _buildNavItem(context, 4, StringsAssetsConstants.projects, Icons.folder),
      _buildNavItem(context, 5, StringsAssetsConstants.skills, Icons.star),
      _buildNavItem(
          context, 6, StringsAssetsConstants.contact, Icons.contact_mail),
    ];
  }

  Widget _buildNavItem(
      BuildContext context, int index, String title, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      child: Obx(() => ListTile(
            leading: Icon(
              icon,
              color: controller.currentPageIndex.value == index
                  ? MainColors.primaryColor(context)
                  : Colors.grey.shade600,
              // size: 24.sp,
            ),
            title: Text(
              title,
              style: TextStyles.labelTiny(context).copyWith(
                color: controller.currentPageIndex.value == index
                    ? MainColors.primaryColor(context)
                    : Colors.grey.shade700,
                // fontSize: 12.sp,
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            tileColor: controller.currentPageIndex.value == index
                ? MainColors.primaryColor(context).withValues(alpha: 0.15)
                : Colors.transparent,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            onTap: () => controller.changePage(index),
          )),
    );
  }

  Widget _buildDynamicContent() {
    return Obx(() {
      final currentTitle = controller.currentPage;

      switch (currentTitle) {
        case 'About':
          return const AboutView();
        case 'Contact':
          return ContactView();
        case 'Education':
          return EducationView();
        case 'Experience':
          return ExperianceView();
        case 'Home':
          return HomeView();
        case 'Projects':
          return ProjectsView();
        case 'Skills':
          return const SkillsView();
        default:
          return HomeView();
      }
    });
  }
}

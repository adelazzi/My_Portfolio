// ignore_for_file: deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/app/core/constants/icons_assets_constants.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/core/utils/portfolio_data.dart';
import 'package:my_portfolio/app/modules/home/controllers/home_controller.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';
import 'package:my_portfolio/app/modules/user_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  StringsAssetsConstants.hiIm,
                  style: TextStyles.bodySmall(context),
                ),
                Text(
                  StringsAssetsConstants.fullName,
                  style: TextStyle(
                    color: MainColors.primaryBrand,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                )
              ],
            ),
            Obx(() => SizedBox(
                  height: 100.h,
                  child: DefaultTextStyle(
                    style: TextStyles.labelTiny(context),
                    child: PortfolioData.roles.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AnimatedTextKit(
                                animatedTexts: PortfolioData.roles
                                    .map((role) => RotateAnimatedText(
                                          role,
                                          textStyle:
                                              TextStyles.labelSmall(context),
                                        ))
                                    .toList(),
                                totalRepeatCount: 10,
                                pause: Duration(milliseconds: 1000),
                                repeatForever: false,
                              ),
                            ],
                          )
                        : Text(
                            'Flutter Developer',
                            style: TextStyles.labelMedium(context)
                                .copyWith(fontSize: 24.sp),
                          ),
                  ),
                )),
            Row(
              children: [
                InkWell(
                  onHover: (value) {},
                  onTap: () {
                    Get.find<MainpageController>().changePage(6);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45.r),
                      color: MainColors.primaryBrand,
                      boxShadow: [
                        BoxShadow(
                          color: MainColors.shadowColor(context),
                          spreadRadius: 3.r,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 8.sp,
                          color: MainColors.whiteColor,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          StringsAssetsConstants.hireMeCTA,
                          style: TextStyles.bodySmall(context),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                InkWell(
                  onHover: (value) {},
                  onTap: () {
                    Get.find<MainpageController>().changePage(1);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MainColors.primaryBrand,
                      ),
                      borderRadius: BorderRadius.circular(45.r),
                      color: MainColors.backgroundColor(context),
                      boxShadow: [
                        BoxShadow(
                          color: MainColors.primaryBrand.withOpacity(0.4),
                          spreadRadius: 3.r,
                        )
                      ],
                    ),
                    child: Text(
                      StringsAssetsConstants.aboutTitle,
                      style: TextStyles.bodySmall(context),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.w,
            ),
            Text(
              "Everything about me . \n Transforming bold ideas into creative Flutter reality 🚀",
              style: TextStyles.bodySmall(context).copyWith(
                  color: MainColors.textColor(context).withOpacity(0.6)),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      techs(
                        logo: IconsAssetsConstants.flutter,
                        color: MainColors.indicatorColor,
                      ),
                      techs(
                        logo: IconsAssetsConstants.dart,
                        color: MainColors.successColor(context),
                      ),
                      techs(
                        logo: IconsAssetsConstants.django,
                        color: MainColors.primaryBrand,
                      ),
                      techs(
                        logo: IconsAssetsConstants.pythion,
                        color: MainColors.inactiveColor,
                      ),
                      techs(
                        logo: IconsAssetsConstants.firebase,
                        color: MainColors.pendingColor,
                      ),
                      techs(
                        logo: IconsAssetsConstants.supabase,
                        color: MainColors.secondaryBrand,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    height: Get.height * 0.58,
                    width: Get.width * 0.2,
                    child: Image.asset(
                      'images/home_1.png',
                      fit: BoxFit.cover,
                      matchTextDirection: true,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class techs extends StatelessWidget {
  techs({
    required this.logo,
    required this.color,
    super.key,
  });
  String logo;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      width: 20.w,
      height: 20.w,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: MainColors.backgroundColor(context),
          border: Border.all(width: 1, color: color),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 2,
            )
          ]),
      child: Image.asset(logo),
    );
  }
}

class HomeViewMobile extends GetView<HomeController> {
  HomeViewMobile({Key? key}) : super(key: key);
  final HomeController c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true, // ✅ Fits parent height

      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      children: [
        // Greeting Section
        SizedBox(height: 40.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(StringsAssetsConstants.hiIm),
            Text(
              StringsAssetsConstants.fullName,
              style: TextStyle(
                color: MainColors.primaryBrand,
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
              ),
            ),
          ],
        ),

        // Animated Roles
        SizedBox(height: 20.h),
        SizedBox(
          height: 80.h,
          width: double.infinity,
          child: DefaultTextStyle(
            style: TextStyles.bodyMedium(context),
            child: Obx(() => PortfolioData.roles.isNotEmpty
                ? AnimatedTextKit(
                    animatedTexts: PortfolioData.roles
                        .map((role) => RotateAnimatedText(
                              role,
                              textStyle: TextStyles.bodyLarge(context),
                            ))
                        .toList(),
                    totalRepeatCount: 10,
                    pause: Duration(milliseconds: 1000),
                  )
                : Text('Flutter Developer')),
          ),
        ),


        // Description
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            //TODO
            "Everything about me. Transforming bold ideas into creative Flutter reality 🚀",
            style: TextStyles.bodyMedium(context),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: 40.h),
      ],
    );
  }
}

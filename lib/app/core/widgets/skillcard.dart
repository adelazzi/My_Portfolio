// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';

class SkillTile extends StatelessWidget {
  final Skill skill;
  Color? color;
  SkillTile({Key? key, required this.skill, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color!.withOpacity(0.12) ?? Colors.white.withOpacity(0.12),
            color!.withOpacity(0.3) ?? Colors.white.withOpacity(0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 1.w,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12.r,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Skill Name
          Text(
            skill.name,
            style: TextStyles.labelTiny(context),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),

          // Sleek Progress Indicator
          Stack(
            children: [
              // Background track
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: MainColors.backgroundColor(context),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              // Progress fill

              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: (color ?? Colors.cyan).withOpacity(0.3),
                      blurRadius: 4.r,
                      spreadRadius: 0.5,
                    ),
                  ],
                  // color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Container(
                  width: skill.proficiency * 100.w, // ✅ Fixed width
                  decoration: BoxDecoration(
                    gradient: color != null
                        ? LinearGradient(colors: [
                            color!.withOpacity(0.7),
                            color!.withOpacity(0.4),
                          ])
                        : MainColors.primaryGradient,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 6.h),

          // Proficiency %
          Text(
            '${(skill.proficiency * 100).toInt()}%',
            style: TextStyles.bodyTiny(context).copyWith(
              color: Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w600,
              // fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}

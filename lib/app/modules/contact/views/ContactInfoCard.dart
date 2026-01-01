import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';

class ContactInfoCard extends StatelessWidget {
  final String email;
  final String phone;
  final String location;

  const ContactInfoCard({
    Key? key,
    required this.email,
    required this.phone,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      margin: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
          color: MainColors.inactiveColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            'Contact Information',
            style: TextStyles.labelTiny(context),
          ),
          SizedBox(height: 12.h),

          // Email & Phone Row
          Row(
            children: [
              // Email
              Expanded(
                child: _buildContactItem(
                  context,
                  Icons.email,
                  'Email',
                  email,
                ),
              ),
              SizedBox(width: 16.w),
              // Phone
              Expanded(
                child: _buildContactItem(
                  context,
                  Icons.phone,
                  'Phone',
                  phone,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Location
          _buildContactItem(
            context,
            Icons.location_on,
            'Location',
            location,
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
          size: 12.sp,
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label - Pure TextStyles.labelTiny
              Text(
                label,
                style: TextStyles.labelTiny(context),
              ),
              SizedBox(height: 4.h),
              // Value - Pure TextStyles.bodyTiny
              Text(
                value,
                style: TextStyles.bodyTiny(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

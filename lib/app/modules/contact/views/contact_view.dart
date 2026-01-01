// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:my_portfolio/app/core/constants/constant_url.dart';
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/styles/colors.dart';
import 'package:my_portfolio/app/core/styles/text_styles.dart';
import 'package:my_portfolio/app/core/toast_component.dart';
import 'package:my_portfolio/app/modules/contact/controllers/contact_controller.dart';
import 'package:my_portfolio/app/modules/contact/views/ContactInfoCard.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactView extends StatelessWidget {
  ContactView({Key? key}) : super(key: key);
  ContactController controller = Get.put(ContactController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.h),

            // Section Title
            Text(
              StringsAssetsConstants.contactTitle,
              style: TextStyles.labelSmall(context).copyWith(),
            ),
            SizedBox(height: 8.h),
            Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                color: MainColors.inactiveColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Contact intro text
            Text(
              StringsAssetsConstants.getInTouch,
              style: TextStyles.bodySmall(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),

            _buildContactForm(context),
            SizedBox(height: 25.h),

            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringsAssetsConstants.sendMeMessage,
                style: TextStyles.bodyTiny(context),
              ),
              SizedBox(
                height: 20.h,
              ),
              // Name Fieldr.
              TextFormField(
                style: TextStyles.bodyTiny(context), // ✅ Input text size

                controller: controller.nameController,
                decoration: InputDecoration(
                  errorStyle: TextStyles.bodyTiny(context)
                      .copyWith(color: MainColors.errorColor(context)),
                  labelText: StringsAssetsConstants.yourName,
                  labelStyle: TextStyles.bodyTiny(context),
                  prefixIcon: const Icon(Icons.person),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringsAssetsConstants.pleaseEnterName;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),

              // Email Field
              TextFormField(
                style: TextStyles.bodyTiny(context), // ✅ Input text size

                controller: controller.emailController,
                decoration: InputDecoration(
                  errorStyle: TextStyles.bodyTiny(context)
                      .copyWith(color: MainColors.errorColor(context)),
                  labelText: StringsAssetsConstants.yourEmail,
                  labelStyle: TextStyles.bodyTiny(context),
                  prefixIcon: const Icon(Icons.email),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringsAssetsConstants.pleaseEnterEmail;
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return StringsAssetsConstants.pleaseEnterValidEmail;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),

              // Message Field
              TextFormField(
                style: TextStyles.bodyTiny(context), // ✅ Input text size

                controller: controller.messageController,
                decoration: InputDecoration(
                  errorStyle: TextStyles.bodyTiny(context)
                      .copyWith(color: MainColors.errorColor(context)),
                  labelText: StringsAssetsConstants.yourMessage,
                  counterStyle: TextStyles.bodyTiny(context),
                  labelStyle: TextStyles.bodyTiny(context),
                  prefixIcon: const Icon(Icons.message),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringsAssetsConstants.yourMessage;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),

              // Submit Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: Icon(
                    Icons.send,
                    color: MainColors.whiteColor,
                  ),
                  label: Text(
                    StringsAssetsConstants.sendMessage,
                    style: TextStyles.bodyTiny(context),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainColors.primaryBrand,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Logo(Logos.github),
              color: Colors.white,
              onPressed: () async {
                final uri = Uri.parse(UrlsConstants.github);
                const mode = LaunchMode.externalApplication;

                if (!await launchUrl(uri, mode: mode)) {
                  debugPrint('Could not launch ');
                }
              },
            ),
            IconButton(
              icon: Logo(Logos.linkedin),
              color: Colors.white,
              onPressed: () async {
                final uri = Uri.parse(UrlsConstants.linkedin);
                const mode = LaunchMode.externalApplication;

                if (!await launchUrl(uri, mode: mode)) {
                  debugPrint('Could not launch AppConstants.linkedin}');
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          '© ${DateTime.now().year}  ${StringsAssetsConstants.fullName} .${StringsAssetsConstants.allRightsReserved}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          StringsAssetsConstants.builtWithFlutter,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _submitForm() async {
    if (controller.formKey.currentState!.validate()) {
      final name = controller.nameController.text;
      final email = controller.emailController.text;
      final message = controller.messageController.text;

      final uri = Uri.parse(
          'https://formspree.io/f/xgvyljqb'); // Replace with your form ID
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: '''{
          "name": "$name",
          "email": "$email",
          "message": "$message"
        }''',
      );
      if (response.statusCode == 200) {
        ToastComponent().showDesktopToast(
          Get.context!,
          message:
              '${StringsAssetsConstants.thankYou} $name! ${StringsAssetsConstants.messageSent}',
          type: ToastTypes.success,
        );

        // Clear the form
        controller.nameController.clear();
        controller.emailController.clear();
        controller.messageController.clear();
      } else {
        ToastComponent().showDesktopToast(
          Get.context!,
          message: StringsAssetsConstants.oopsSomethingWrong,
          type: ToastTypes.error,
        );
      }
    }
  }
}

class ContactViewMobile extends StatelessWidget {
  ContactViewMobile({Key? key}) : super(key: key);

  ContactController controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Essential for ListView
        children: [
          // Section Title - Compact for ListView
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: MainColors.primaryBrand.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.contact_mail,
                    size: 18.sp, color: MainColors.primaryBrand),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringsAssetsConstants.contactTitle,
                    style: TextStyles.labelMedium(context).copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                  ),
                  Container(
                    width: 60.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: MainColors.inactiveColor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Contact intro text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              StringsAssetsConstants.getInTouch,
              style: TextStyles.bodyMedium(context),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),

          _buildContactForm(context),
          SizedBox(height: 24.h),

          _buildFooter(context),
          SizedBox(height: 8.h), // Bottom padding for ListView
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2);
  }

  Widget _buildContactForm(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Text(
                  StringsAssetsConstants.sendMeMessage,
                  style: TextStyles.bodyMedium(context).copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),

              // Name Field
              _buildTextField(
                controller: controller.nameController,
                icon: Icons.person,
                label: StringsAssetsConstants.yourName,
                validator: (value) => value?.isEmpty == true
                    ? StringsAssetsConstants.pleaseEnterName
                    : null,
              ),

              SizedBox(height: 16.h),

              // Email Field
              _buildTextField(
                controller: controller.emailController,
                icon: Icons.email,
                label: StringsAssetsConstants.yourEmail,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return StringsAssetsConstants.pleaseEnterEmail;
                  }
                  if (!value!.contains('@') || !value.contains('.')) {
                    return StringsAssetsConstants.pleaseEnterValidEmail;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Message Field
              _buildTextField(
                controller: controller.messageController,
                icon: Icons.message,
                label: StringsAssetsConstants.yourMessage,
                maxLines: 3,
                validator: (value) => value?.isEmpty == true
                    ? StringsAssetsConstants.yourMessage
                    : null,
              ),
              SizedBox(height: 20.h),

              // Submit Button - Full width for mobile
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _submitForm(context),
                  icon: Icon(Icons.send, size: 18.sp),
                  label: Text(
                    StringsAssetsConstants.sendMessage,
                    style: TextStyles.bodyMedium(context),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MainColors.primaryBrand,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyles.bodyMedium(Get.context!),
      decoration: InputDecoration(
        errorStyle: TextStyles.bodySmall(Get.context!)
            .copyWith(color: MainColors.errorColor(Get.context!)),
        labelText: label,
        labelStyle: TextStyles.bodySmall(Get.context!),
        prefixIcon: Icon(icon, size: 20.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
      validator: validator,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: MainColors.primaryBrand.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Social Icons - Larger touch targets
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialButton(
                icon: Logo(Logos.github),
                url: UrlsConstants.github,
              ),
              _buildSocialButton(
                icon: Logo(Logos.linkedin),
                url: UrlsConstants.linkedin,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '© ${DateTime.now().year} ${StringsAssetsConstants.fullName}. ${StringsAssetsConstants.allRightsReserved}',
            style: TextStyles.bodySmall(context).copyWith(
              color: Colors.grey[600],
              fontSize: 12.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            StringsAssetsConstants.builtWithFlutter,
            style: TextStyles.bodySmall(context).copyWith(
              color: Colors.grey[500],
              fontSize: 11.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required Widget icon,
    required String url,
  }) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: MainColors.backgroundColor(Get.context!),
          border: Border.all(color: MainColors.primaryBrand, width: 1),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: MainColors.primaryBrand.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: icon,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  void _submitForm(BuildContext context) async {
    if (controller.formKey.currentState!.validate()) {
      // Your existing form submission logic here
      final name = controller.nameController.text;
      final email = controller.emailController.text;
      final message = controller.messageController.text;

      final uri = Uri.parse('https://formspree.io/f/xgvyljqb');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: '''{
          "name": "$name",
          "email": "$email",
          "message": "$message"
        }''',
      );

      if (response.statusCode == 200) {
        ToastComponent().showDesktopToast(
          context,
          message:
              '${StringsAssetsConstants.thankYou} $name! ${StringsAssetsConstants.messageSent}',
          type: ToastTypes.success,
        );
        // controller.clear();
      } else {
        ToastComponent().showDesktopToast(
          context,
          message: StringsAssetsConstants.oopsSomethingWrong,
          type: ToastTypes.error,
        );
      }
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_portfolio/app/core/constants/strings_assets_constants.dart';
import 'package:my_portfolio/app/core/toast_component.dart';

class ContactController extends GetxController {
  static final Uri _formspreeUri = Uri.parse('https://formspree.io/f/xgvyljqb');

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final RxBool isSending = false.obs;

  Future<void> submitForm(BuildContext context, {required bool isDesktop}) async {
    if (isSending.value || !(formKey.currentState?.validate() ?? false)) return;

    final name = nameController.text.trim();
    isSending.value = true;
    bool sent = false;
    try {
      final response = await http
          .post(
            _formspreeUri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'name': name,
              'email': emailController.text.trim(),
              'message': messageController.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 15));
      sent = response.statusCode >= 200 && response.statusCode < 300;
    } catch (_) {
      sent = false;
    } finally {
      isSending.value = false;
    }

    if (!context.mounted) return;
    final message = sent
        ? '${StringsAssetsConstants.thankYou} $name! ${StringsAssetsConstants.messageSent}'
        : StringsAssetsConstants.oopsSomethingWrong;
    final type = sent ? ToastTypes.success : ToastTypes.error;
    if (isDesktop) {
      ToastComponent().showDesktopToast(context, message: message, type: type);
    } else {
      ToastComponent().showMobileToast(context, message: message, type: type);
    }

    if (sent) {
      nameController.clear();
      emailController.clear();
      messageController.clear();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}

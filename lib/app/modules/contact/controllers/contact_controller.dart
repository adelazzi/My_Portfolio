import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

enum SendStatus { idle, sending, sent, failed }

class ContactController extends GetxController {
  static final Uri _formspreeUri = Uri.parse('https://formspree.io/f/xgvyljqb');

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final Rx<SendStatus> status = SendStatus.idle.obs;

  bool get isSending => status.value == SendStatus.sending;

  Future<void> submitForm() async {
    if (isSending || !(formKey.currentState?.validate() ?? false)) return;

    status.value = SendStatus.sending;
    try {
      final response = await http
          .post(
            _formspreeUri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'name': nameController.text.trim(),
              'email': emailController.text.trim(),
              'message': messageController.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 15));
      final sent = response.statusCode >= 200 && response.statusCode < 300;
      status.value = sent ? SendStatus.sent : SendStatus.failed;
    } catch (_) {
      status.value = SendStatus.failed;
    }

    if (status.value == SendStatus.sent) {
      nameController.clear();
      emailController.clear();
      messageController.clear();
    }
  }

  /// Hides the last result once the visitor starts typing again.
  void clearResult() {
    if (status.value == SendStatus.sent || status.value == SendStatus.failed) {
      status.value = SendStatus.idle;
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

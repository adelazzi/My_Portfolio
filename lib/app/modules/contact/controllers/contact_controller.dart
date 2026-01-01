import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  // Add your controller logic here
    final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

}

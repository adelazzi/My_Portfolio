import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainpageController extends GetxController {
  // ✅ List of all pages
  final List<Map<String, dynamic>> pages = [
    {'title': 'Home', 'icon': Icons.home}, // Landing page
    {'title': 'About', 'icon': Icons.person}, // Personal profile
    {'title': 'Education', 'icon': Icons.school}, // Academic background
    {'title': 'Experience', 'icon': Icons.work}, // Work history
    {'title': 'Projects', 'icon': Icons.folder}, // Portfolio projects
    {'title': 'Skills', 'icon': Icons.star},
    {'title': 'Contact', 'icon': Icons.contact_mail}, // Contact info
  ];
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  // ✅ Current selected page index
  final RxInt currentPageIndex = 0.obs;

  // ✅ Get current page title
  String get currentPage => pages[currentPageIndex.value]['title'];

  // ✅ Change page by index
  void changePage(int index) {
    currentPageIndex.value = index;
  }

  // ✅ Change page by title
  void changePageByTitle(String title) {
    final index = pages.indexWhere((page) => page['title'] == title);
    if (index != -1) {
      currentPageIndex.value = index;
    }
  }
}

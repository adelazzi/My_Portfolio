import 'package:get/get.dart';

// HomeController.dart
class HomeController extends GetxController with GetTickerProviderStateMixin {
  final RxInt phraseIndex = 0.obs;

  final List<String> phrases = [
    "Flutter Developer",
    "GetX Enthusiast",
    "Full-Stack Coder",
    "UI/UX Designer",
    "Creative Problem Solver",
    "Portfolio Builder"
  ];

  @override
  void onInit() {
    super.onInit();
  }
}

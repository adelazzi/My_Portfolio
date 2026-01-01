import 'package:get/get.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';

class ProjectsController extends GetxController {
  var projects = <Project>[].obs;
  var isLoading = false.obs;


  Future<void> loadProjects() async {
    isLoading.value = true;
    try {
      // Load your projects from API, local, or static
      await Future.delayed(const Duration(seconds: 1)); // Simulate API
    } catch (e) {
      Get.snackbar('Error', 'Failed to load projects');
    } finally {
      isLoading.value = false;
    }
  }
}

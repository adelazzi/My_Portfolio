import 'package:get/get.dart';
import 'package:my_portfolio/app/models/portfolio_models.dart';
class SkillsController extends GetxController {
  var skills = <Skill>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSkills();
  }

  void loadSkills() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    
   
    isLoading.value = false;
  }
}

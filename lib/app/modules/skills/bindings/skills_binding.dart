import 'package:get/get.dart';
import 'package:my_portfolio/app/modules/skills/controllers/skills_controller.dart';

class SkillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SkillsController>(() => SkillsController());
  }
}

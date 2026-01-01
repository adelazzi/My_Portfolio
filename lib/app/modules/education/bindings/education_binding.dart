import 'package:get/get.dart';
import 'package:my_portfolio/app/modules/education/controllers/education_controller.dart';

class EducationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EducationController>(() => EducationController());
  }
}

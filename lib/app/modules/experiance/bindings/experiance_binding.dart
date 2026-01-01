import 'package:get/get.dart';
import 'package:my_portfolio/app/modules/experiance/controllers/experiance_controller.dart';

class ExperianceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExperianceController>(() => ExperianceController());
  }
}

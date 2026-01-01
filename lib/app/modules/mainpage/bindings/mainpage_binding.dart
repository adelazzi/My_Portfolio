import 'package:get/get.dart';
import 'package:my_portfolio/app/modules/mainpage/controllers/mainpage_controller.dart';

class MainpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainpageController>(() => MainpageController());
  }
}

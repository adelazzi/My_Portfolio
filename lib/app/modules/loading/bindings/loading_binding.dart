import 'package:get/get.dart';
import 'package:my_portfolio/app/modules/loading/controllers/loading_controller.dart';

class LoadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingController>(() => LoadingController());
  }
}

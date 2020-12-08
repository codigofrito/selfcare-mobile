import 'package:get/get.dart';

import 'controller.dart';

class SplashScreenBind extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreenController>(SplashScreenController());
  }
}

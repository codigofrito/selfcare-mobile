import 'package:get/get.dart';
import 'controller.dart';

class LandingPageScreenBind extends Bindings {
  @override
  void dependencies() {
    Get.put<LandingPageScreenController>(LandingPageScreenController());
  }
}

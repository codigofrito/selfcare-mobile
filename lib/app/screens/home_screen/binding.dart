import 'package:get/get.dart';
import 'package:selfcare/app/shared/components/custom_app_bar/controller.dart';

import 'controller.dart';

class HomeScreenBind extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeScreenController>(
      HomeScreenController(),
    );
    Get.put<CustomAppBarController>(
      CustomAppBarController(),
    );
  }
}

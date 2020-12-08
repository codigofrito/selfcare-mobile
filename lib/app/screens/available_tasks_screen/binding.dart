import 'package:get/get.dart';
import 'package:selfcare/app/shared/components/custom_app_bar/controller.dart';

import 'controller.dart';

class AvailableTasksScreenBind extends Bindings {
  @override
  void dependencies() {
    Get.put<AvailableTasksScreenController>(
      AvailableTasksScreenController(),
    );
    Get.put<CustomAppBarController>(
      CustomAppBarController(),
    );
  }
}

import 'package:get/get.dart';
import 'controller.dart';

class AvailableTasksScreenBind extends Bindings {
  @override
  void dependencies() {
    Get.put<AvailableTasksScreenController>(
      AvailableTasksScreenController(),
    );
  }
}

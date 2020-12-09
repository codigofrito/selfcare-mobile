import 'package:get/get.dart';
import 'controller.dart';

class UserTaskDetailsScreenBind extends Bindings {
  @override
  void dependencies() {
    Get.put<UserTaskDetailsScreenController>(
      UserTaskDetailsScreenController(),
    );
  }
}

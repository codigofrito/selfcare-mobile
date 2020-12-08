import 'package:get/get.dart';

import 'controller.dart';

class SignInScreenBind extends Bindings {
  @override
  void dependencies() {
    Get.put<SignInScreenController>(SignInScreenController());
  }
}

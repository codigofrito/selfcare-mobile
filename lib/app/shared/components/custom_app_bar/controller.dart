//import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/screens/splash_screen/binding.dart';
import 'package:selfcare/app/screens/splash_screen/view.dart';

class CustomAppBarController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController rotateHandsController;

  @override
  void onInit() async {
    rotateHandsController = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);

    rotateHandsController.repeat();

    super.onInit();
  }

  @override
  void onReady() {
    Future.delayed(Duration(milliseconds: 2200), () async {
      rotateHandsController.stop();
    });
    super.onReady();
  }

  @override
  void dispose() {
    rotateHandsController.dispose();
    super.dispose();
  }

  Future<void> sigOut() async {
    await Get.find<SessionUser>().sigOut();

    Get.offAll(
      SplashScreen(),
      binding: SplashScreenBind(),
      duration: Duration(milliseconds: 500),
      transition: Transition.fadeIn,
      curve: Curves.easeInBack,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/screens/home_screen/binding.dart';
import 'package:selfcare/app/screens/home_screen/view.dart';
import 'package:selfcare/app/screens/landing_page_screen/binding.dart';
import 'package:selfcare/app/screens/landing_page_screen/view.dart';

class SplashScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController rotateHandsController;

  @override
  void onInit() async {
    rotateHandsController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    rotateHandsController.repeat();

    super.onInit();
  }

  @override
  void dispose() {
    rotateHandsController.dispose();
    super.dispose();
  }

  @override
  void onReady() async {
    super.onReady();

    SessionUser currentUser = Get.find<SessionUser>();
    await currentUser.signInFromLocalStorage();

    Future.delayed(Duration(milliseconds: 1500), () async {
      if (currentUser.isLogged) {
        Get.offAll(
          HomeScreen(),
          binding: HomeScreenBind(),
          duration: Duration(milliseconds: 2000),
          transition: Transition.fadeIn,
          curve: Curves.easeIn,
        );
      } else {
        Get.offAll(
          LandingPageScreen(),
          binding: LandingPageScreenBind(),
          duration: Duration(milliseconds: 2000),
          transition: Transition.fadeIn,
          curve: Curves.easeOut,
        );
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPageScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController rotateHandsController;
  PageController pageViewController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1,
  );

  @override
  void onInit() async {
    rotateHandsController = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    rotateHandsController.repeat();
    super.onInit();
  }

  @override
  void dispose() {
    rotateHandsController.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    Future.delayed(Duration(milliseconds: 2200), () async {
      rotateHandsController.stop();
    });
    super.onReady();
  }

  RxInt _currentIndexPage = 0.obs;
  int get currentIndexPage => _currentIndexPage.value;
  set currentIndexPage(int indexPageValue) {
    this._currentIndexPage.value = indexPageValue;
  }

  showModal() {}
}

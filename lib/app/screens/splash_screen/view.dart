import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/shared/utils/custom-color-filters.dart';
import 'controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Hero(
          tag: 'logo',
          child: SizedBox(
            width: Get.width / 4,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/brand/logo-only-heart.svg',
                    height: 110,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: RotationTransition(
                    turns: controller.rotateHandsController,
                    child: ColorFiltered(
                      colorFilter: CustomColorFilter.softGreyscale,
                      child: SvgPicture.asset(
                        'assets/images/brand/logo-only-hands.svg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

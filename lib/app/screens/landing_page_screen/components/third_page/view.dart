import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/routes/screen_routes.dart';
import '../../controller.dart';

class ThirdPage extends GetView<LandingPageScreenController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: Get.width * .7,
              child: Image.asset("assets/images/brand/landing-page-3.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Text(
              "Vocês são importantes,",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Text(
              "Cuidem-se também!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: MaterialButton(
              height: 50,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "INICIAR",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () => Get.toNamed(ScreenRoutes.SIGN_IN),
            ),
          ),
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'components/first_page/view.dart';
import 'components/second_page/view.dart';
import 'components/third_page/view.dart';
import 'controller.dart';

class LandingPageScreen extends GetView<LandingPageScreenController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              onPageChanged: (int indexPage) {
                controller.currentIndexPage = indexPage;
              },
              controller: controller.pageViewController,
              children: <Widget>[
                FistPage(),
                SecondPage(),
                ThirdPage(),
              ],
            ),
            Positioned(
                bottom: 20,
                child: SizedBox(
                  width: Get.width,
                  height: 80,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _buildPageIndicator(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Offstage(
                                offstage: controller.currentIndexPage < 1,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: MaterialButton(
                                    height: 50,
                                    color: Colors.grey[100],
                                    child: Text(
                                      "Voltar",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onPressed: () => controller
                                        .pageViewController
                                        .previousPage(
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.ease),
                                  ),
                                ),
                              ),
                              Offstage(
                                offstage: controller.currentIndexPage > 1,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: MaterialButton(
                                    height: 50,
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    child: Text(
                                      "Próximo",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () =>
                                        controller.pageViewController.nextPage(
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.ease),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                )),
            Positioned(
              top: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        createRectTween: (begin, end) {
                          return RectTween(begin: begin, end: end);
                        },
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
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
                                  child: SvgPicture.asset(
                                    'assets/images/brand/logo-only-hands.svg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Self Care",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == controller.currentIndexPage
          ? _indicator(true)
          : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Theme.of(Get.context).primaryColor : Colors.grey[200],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/shared/utils/custom-color-filters.dart';
import 'controller.dart';

class CustomAppBar extends GetView<CustomAppBarController>
    with PreferredSizeWidget {
  @override
  final Size preferredSize = Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      bottomOpacity: 0,
      elevation: 0,
      actions: !Get.find<SessionUser>().isLogged
          ? []
          : [
              IconButton(
                onPressed: () => showDialog(
                  barrierColor: Colors.black.withOpacity(0.1),
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                        "${Get.find<PackageInfo>().appName} v${Get.find<PackageInfo>().version}"),
                    content: Text("Aplicativo do projeto eutambem\n"),
                    actions: [],
                  ),
                ),
                icon: Hero(
                  tag: 'info',
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              createRectTween: (begin, end) {
                return RectTween(begin: begin, end: end);
              },
              child: SizedBox(
                height: 30,
                width: 30,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/brand/logo-only-heart.svg',
                      height: 80,
                    ),
                    ColorFiltered(
                      colorFilter: CustomColorFilter.softGreyscale,
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
            Hero(
              tag: 'logo-text',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "Self Care",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

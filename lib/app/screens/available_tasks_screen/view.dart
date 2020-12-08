import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/shared/utils/moment.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:flutter/material.dart';
import 'package:selfcare/app/shared/components/custom_app_bar/view.dart';

import 'controller.dart';

class AvailableTasksScreen extends GetView<AvailableTasksScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () => controller.refresh(),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: Text(
                      "Adicione mais uma tarefa a sua lista:",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      (controller.availableTaskList.length ??
                          controller.perPage),
                      (index) => userTaskRow(index),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userTaskRow(indexTask) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            SizedBox(
              width: Get.width,
              height: Get.width * 0.8,
            ),
            Positioned(
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Hero(
                  tag: 'taskImage$indexTask',
                  createRectTween: (begin, end) {
                    return RectTween(begin: begin, end: end);
                  },
                  child: Container(
                    width: Get.width * 0.8,
                    height: Get.width * 0.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          controller.availableTaskList[indexTask]?.imageUrl ??
                              "",
                        ),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: RawMaterialButton(
                  onPressed: () => Moment.nextDates(DateTime.now(), 5),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: FaIcon(
                    FontAwesomeIcons.clock,
                    color: TinyColor(Theme.of(Get.context).primaryColor)
                        .darken(30)
                        .color,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ),
            ),
          ],
        ),
      );
}

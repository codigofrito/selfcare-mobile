import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/routes/screen_routes.dart';
import 'package:selfcare/app/shared/utils/moment.dart';
import 'package:tinycolor/tinycolor.dart';
import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:selfcare/app/shared/components/custom_app_bar/view.dart';
import 'package:selfcare/app/shared/components/page_header/view.dart';

class HomeScreen extends GetView<HomeScreenController> {
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
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 175,
                    ),
                    PageHeader(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: CircularPercentIndicator(
                              radius: 90.0,
                              lineWidth: 5.0,
                              animation: true,
                              percent: 0.25,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.red,
                              backgroundColor: Colors.white,
                              center: CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                radius: 35.0,
                                backgroundImage: Get.find<SessionUser>()
                                        .userData
                                        .userUrlPhoto
                                        .isNullOrBlank
                                    ? AssetImage(
                                        'assets/images/utils/default_avatar.png',
                                      )
                                    : NetworkImage(
                                        Get.find<SessionUser>()
                                            .userData
                                            .userUrlPhoto,
                                      ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  FittedBox(
                                    child: Text(
                                      Get.find<SessionUser>().userData.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "3 tarefas realizadas",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () => controller.sigOut(),
                              child: FaIcon(
                                FontAwesomeIcons.signOutAlt,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 20,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () =>
                                Get.toNamed(ScreenRoutes.AVAILABLE_TASKS),
                            elevation: 2.0,
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.add_to_photos,
                              color: TinyColor(Theme.of(context).primaryColor)
                                  .darken(30)
                                  .color,
                              size: 35.0,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                          Offstage(
                            offstage: false ?? true,
                            child: Container(
                              width: 30,
                              height: 30,
                              child: Center(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: Text(
                                    "${controller.newTasksAvaliable}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: Text(
                      "Minhas tarefas:",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: controller.isloading
                      ? Container(
                          child: userTaskRow(),
                        )
                      : controller.sessionUser.userTaskList.isEmpty
                          ? Container(
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Image.asset(
                                      'assets/images/utils/emptyTesks.png',
                                      width: Get.width / 2,
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Sua lista está vazia!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "Comece adicionando alguma terefa.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                (controller.sessionUser.userTaskList.length),
                                (index) => userTaskRow(index),
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

  Widget userTaskRow([int indexTask]) => Obx(
        () => SizedBox(
          height: 380,
          width: Get.width,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 0,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: 280,
                      height: 320,
                    ),
                    Positioned(
                      top: 20,
                      child: SizedBox(
                        width: 280,
                        height: 280,
                        child: GestureDetector(
                          onTap: () => indexTask.isNull
                              ? {}
                              : controller.openTaskDetails(indexTask),
                          child: Hero(
                            tag: 'userTaskImage${indexTask ?? 0}',
                            createRectTween: (begin, end) {
                              return RectTween(begin: begin, end: end);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: indexTask == null
                                      ? AssetImage(
                                          'assets/images/utils/empty_image.png')
                                      : controller
                                                  .sessionUser
                                                  .userTaskList[indexTask]
                                                  .task
                                                  .imageUrl ==
                                              null
                                          ? AssetImage(
                                              'assets/images/utils/empty_image.png')
                                          : NetworkImage(
                                              controller
                                                  .sessionUser
                                                  .userTaskList[indexTask]
                                                  .task
                                                  ?.imageUrl,
                                            ),
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 20,
                      child: Container(
                        color: Colors.grey[200],
                        height: 50,
                        width: 200,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: Text(
                              "${controller.sessionUser.userTaskList.isNotEmpty ? controller.sessionUser.userTaskList[indexTask].task.title : ""}",
                              style: TextStyle(
                                color: TinyColor(
                                        Theme.of(Get.context).primaryColor)
                                    .darken(30)
                                    .color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: Get.width,
                  ),
                  Positioned(
                    top: 2,
                    left: 58,
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        color: TinyColor(Theme.of(Get.context).primaryColor)
                            .darken(10)
                            .color,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 20,
                                color: Colors.white,
                              ),
                              Text(
                                "${controller.sessionUser.userTaskList.isNotEmpty ? controller.sessionUser.userTaskList[indexTask].schedule.substring(0, 5) : ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 50,
                    child: Container(
                      width: 20,
                      height: 6,
                      decoration: BoxDecoration(
                        color: TinyColor(Theme.of(Get.context).primaryColor)
                            .darken(10)
                            .color,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        SizedBox(
                          height: 380,
                        ),
                        Offstage(
                          offstage: (indexTask ?? 0) >=
                              controller.sessionUser.userTaskList.length - 1,
                          child: Container(
                            width: 5,
                            height: 380,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: TinyColor(Theme.of(Get.context).primaryColor)
                                .darken(10)
                                .color,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${controller.sessionUser.userTaskList.isEmpty ? "" : Moment.nextDates(DateTime.now(), int.parse(controller.userTaskList[indexTask].period)).first.day}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 48,
                          child: Container(
                            width: 6,
                            height: 20,
                            decoration: BoxDecoration(
                              color:
                                  TinyColor(Theme.of(Get.context).primaryColor)
                                      .darken(10)
                                      .color,
                              shape: BoxShape.rectangle,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 55,
                          child: Container(
                            width: 40,
                            height: 80,
                            decoration: BoxDecoration(
                              color:
                                  TinyColor(Theme.of(Get.context).primaryColor)
                                      .darken(10)
                                      .color,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Wrap(
                                spacing: -8,
                                direction: Axis.vertical,
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children:
                                    "${controller.sessionUser.userTaskList.isEmpty ? "" : DateFormat('MMM', 'pt_Br').format(Moment.nextDates(DateTime.now(), int.parse(controller.userTaskList[indexTask].period)).first).capitalizeFirst}"
                                        .split("")
                                        .map(
                                          (string) => Text(
                                            string,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

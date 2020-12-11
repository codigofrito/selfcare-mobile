import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/data/models/user_task_model.dart';
import 'package:selfcare/app/data/repositories/users_has_tasks_repository.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/routes/screen_routes.dart';
import 'package:selfcare/app/screens/splash_screen/binding.dart';
import 'package:selfcare/app/screens/splash_screen/view.dart';
import 'package:selfcare/app/shared/utils/moment.dart';

class HomeScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  RxBool _isLoading = true.obs;
  RxInt _perPage = 5.obs;
  RxInt _newTasksAvaliable = 1.obs;
  RxList<UserTaskRow> _userTaskRowList = <UserTaskRow>[].obs;

  List<UserTaskRow> get userTaskRowList => _userTaskRowList;

  SessionUser sessionUser = Get.find<SessionUser>();

  int get newTasksAvaliable => _newTasksAvaliable.value;
  int get perPage => _perPage.value;
  bool get isloading => _isLoading.value;
  List<UserTask> get userTaskList => sessionUser.userTaskList;

  Future<void> fetchTasks() async {
    _isLoading.value = true;
    sessionUser.userTaskList.clear();
    _userTaskRowList.clear();

    UsersHasTasksRepository().index().then(
      (response) {
        _isLoading.value = false;
        this.fillTaskList(
          json.decode(
            response.raw.toString(),
          ),
        );

        _userTaskRowList.sort(
          (userTaskRowA, userTaskRowB) {
            DateTime userTaskRowADateA = userTaskRowA.scheduleDate;
            DateTime userTaskRowADateB = userTaskRowB.scheduleDate;
            return userTaskRowADateA.compareTo(userTaskRowADateB);
          },
        );
      },
    );
  }

  fillTaskList(dynamic json) {
    if (json != null) {
      json.forEach((userTasks) {
        var currentUserTask = UserTask.fromJson(userTasks);

        var scheduleTime = currentUserTask.schedule.split(':');

        currentUserTask.period.forEach((weekDay) {
          _userTaskRowList.add(UserTaskRow(
            Moment.nextDates(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      int.parse(scheduleTime[0]),
                      int.parse(scheduleTime[1]),
                    ),
                    weekDay)
                .first,
            currentUserTask,
          ));
        });

        sessionUser.userTaskList.add(currentUserTask);
      });
    }
  }

  openTaskDetails(int indexTask) {
    Get.toNamed(
      ScreenRoutes.USER_TASK_DETAILS,
      arguments: {
        "key": indexTask,
        "userTask": userTaskRowList[indexTask].userTask,
      },
    );
  }

  Future<void> refresh() async {
    await this.fetchTasks();
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

  @override
  void onReady() {
    this.fetchTasks();
    super.onReady();
  }

  showNotification() {}
}

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

class UserTaskRow {
  DateTime _scheduleDate;
  UserTask _userTask;

  UserTask get userTask => _userTask;
  DateTime get scheduleDate => _scheduleDate;

  UserTaskRow(DateTime scheduleDate, UserTask userTask)
      : _scheduleDate = scheduleDate,
        _userTask = userTask;
}

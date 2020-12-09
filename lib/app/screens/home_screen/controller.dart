import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/data/models/user_task.dart';
import 'package:selfcare/app/data/repositories/user_has_tasks_repository.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/routes/screen_routes.dart';
import 'package:selfcare/app/screens/splash_screen/binding.dart';
import 'package:selfcare/app/screens/splash_screen/view.dart';

class HomeScreenController extends GetxController {
  RxBool _isLoading = true.obs;
  RxInt _perPage = 5.obs;
  RxInt _newTasksAvaliable = 1.obs;

  SessionUser sessionUser = Get.find<SessionUser>();

  int get newTasksAvaliable => _newTasksAvaliable.value;
  int get perPage => _perPage.value;
  bool get isloading => _isLoading.value;
  List<UserTask> get userTaskList => sessionUser.userTaskList;

  Future<void> fetchTasks() async {
    _isLoading.value = true;
    sessionUser.userTaskList.clear();

    UserHasTasksRepository().index().then(
      (response) {
        _isLoading.value = false;
        this.fillTaskList(
          json.decode(
            response.raw.toString(),
          ),
        );
      },
    );
  }

  fillTaskList(dynamic json) {
    if (json != null) {
      json.forEach((userTasks) {
        sessionUser.userTaskList.add(
          UserTask.fromJson(userTasks),
        );
      });
    }
  }

  openTaskDetails(int indexTask) {
    Get.toNamed(
      ScreenRoutes.USER_TASK_DETAILS,
      arguments: {
        "key": indexTask,
        "userTask": userTaskList[indexTask],
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
}

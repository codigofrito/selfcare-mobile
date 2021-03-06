import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/data/models/task_model.dart';
import 'package:selfcare/app/data/models/user_task_model.dart';
import 'package:selfcare/app/data/repositories/task_repository.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/screens/home_screen/controller.dart';
import 'package:selfcare/app/screens/splash_screen/binding.dart';
import 'package:selfcare/app/screens/splash_screen/view.dart';
import 'package:selfcare/app/data/repositories/users_has_tasks_repository.dart';

class AvailableTasksScreenController extends GetxController {
  RxList<Task> _availableTaskList = <Task>[].obs;
  RxBool _isLoading = true.obs;
  RxInt _perPage = 5.obs;
  RxInt _newTasksAvaliable = 1.obs;

  int get newTasksAvaliable => _newTasksAvaliable.value;
  int get perPage => _perPage.value;
  bool get isloading => _isLoading.value;
  List<Task> get availableTaskList => _availableTaskList;

  set availableTaskList(List<Task> newList) {
    _availableTaskList.value = newList;
  }

  Future<void> storeNewUserTask(int taskId, Set period, String schedule) async {
    UsersHasTasksRepository()
        .store(
      UserTask(
        period: period,
        schedule: schedule,
        task: availableTaskList[taskId],
      ),
    )
        .whenComplete(() {
      Get.find<HomeScreenController>().refresh();
      Get.back(closeOverlays: true);
      Get.back();
    });
  }

  Future<void> fetchTasks() async {
    _isLoading.value = true;
    _availableTaskList.clear();

    TaskRepository().index().then(
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

  Future<void> fillTaskList(dynamic json) async {
    if (json != null) {
      await json.forEach((task) {
        _availableTaskList.add(
          Task.fromJson(task),
        );
      });

      Get.find<SessionUser>().userTaskList.forEach((userTask) {
        print(userTask.task.id);
        if (availableTaskList.any((task) {
          return task.id == userTask.task.id;
        })) {
          _availableTaskList.removeWhere((task) => task.id == userTask.task.id);
        }
      });
    }
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

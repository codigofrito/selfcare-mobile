import 'package:get/get.dart';
import 'package:selfcare/app/data/models/user_task_model.dart';
import 'package:selfcare/app/data/models/task_model.dart';
import 'package:selfcare/app/data/repositories/users_has_tasks_repository.dart';
import 'package:selfcare/app/screens/home_screen/controller.dart';

class UserTaskDetailsScreenController extends GetxController {
  Future<void> updateUserTask(Task task, Set period, String schedule) async {

    UsersHasTasksRepository()
        .update(
      UserTask(
        period: period,
        schedule: schedule,
        task: task,
      ),
    )
        .whenComplete(() {
      Get.find<HomeScreenController>().refresh();
      Get.back(closeOverlays: true);
      Get.back();
    });
  }

  Future<void> deleteUserTask(UserTask userTask, int taskKey) async {
    await UsersHasTasksRepository().destroy(userTask).then(
      (response) {
        Get.find<HomeScreenController>().refresh();
        Get.back(closeOverlays: true);
        Get.back();
      },
    );
  }
}

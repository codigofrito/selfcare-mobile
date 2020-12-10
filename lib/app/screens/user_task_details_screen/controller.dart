import 'package:get/get.dart';
import 'package:selfcare/app/data/models/user_task.dart';
import 'package:selfcare/app/data/repositories/users_has_tasks_repository.dart';
import 'package:selfcare/app/screens/home_screen/controller.dart';

class UserTaskDetailsScreenController extends GetxController {
  Future<void> updateTask() {}

  Future<void> deleteTask(UserTask userTask, int taskKey) async {
    await UsersHasTasksRepository().destroy(userTask).then(
      (response) {
        Get.find<HomeScreenController>().refresh();
        Get.back(closeOverlays: true);
        Get.back();
      },
    );
  }
}

import 'package:get/get.dart';
import 'package:selfcare/app/data/repositories/user_has_tasks_repository.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'package:selfcare/app/screens/home_screen/controller.dart';

class UserTaskDetailsScreenController extends GetxController {
  Future<void> updateTask() {}

  Future<void> deleteTask(String taskId, int taskKey) async {

    await UserHasTasksRepository().destroy({
      "taskId": taskId,
    }).then(
      (response) {
        Get.find<HomeScreenController>().refresh();
        Get.back(closeOverlays: true);
        Get.back();
      },
    );

  }
}

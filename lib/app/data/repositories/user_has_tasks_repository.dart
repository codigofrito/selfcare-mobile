import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/data/interfaces/repository_interface.dart';
import 'package:selfcare/app/data/models/task_model.dart';
import 'package:selfcare/app/data/providers/main_api.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';

class UserHasTasksRepository implements MainApiRepository<Task> {
  RepositoryStatus _status = RepositoryStatus.none;
  SessionUser sessionUser = Get.find<SessionUser>();

  @override
  RepositoryStatus get status => this._status;

  Future<RepositoryResponse> index({requestData}) async {
    try {
      _status = RepositoryStatus.requesting;

      final apiRoutePath = '/usersHasTasksById';
      final response = await MainApiProvider.private.post(
        apiRoutePath,
<<<<<<< HEAD
        data: {
          "user_id": "189476123894526", //sessionUser.userData.id,
=======
         data: {
          "user_id": sessionUser.userData.id,
>>>>>>> 3f053bab580172ac49195c4250dc8cf62a26f846
        },
      );
      return RepositoryResponse.succeed(response);
    } on DioError catch (error) {
      return RepositoryResponse.failed(error);
    } finally {
      _status = RepositoryStatus.completed;
    }
  }

  @override
  Future<RepositoryResponse> show(requestData) async {
    try {
      _status = RepositoryStatus.requesting;

      final apiRoutePath = '/usersHasTasksById';
      final response = await MainApiProvider.private.put(
        apiRoutePath,
        data: {
          "user_id": sessionUser.userData.id,
          "task_id": 1001, //requestData['taskId'],
        },
      );

      return RepositoryResponse.succeed(response);
    } on DioError catch (error) {
      return RepositoryResponse.failed(error);
    } finally {
      _status = RepositoryStatus.completed;
    }
  }

  @override
  Future<RepositoryResponse> store(requestData) async {
    try {
      _status = RepositoryStatus.requesting;

      final apiRoutePath = '/usersHasTasks';
      final response = await MainApiProvider.private.post(
        apiRoutePath,
<<<<<<< HEAD
        data: requestData,
=======
        data: {
          "user_id": sessionUser.userData.id,
          "task_id": 1001, //requestData['taskId'],
          "push_notification": "1",
          "period": "3", //requestData['periodSet'],
          "schedule": "15:00", //requestData['scheduleTime'],
        },
>>>>>>> 3f053bab580172ac49195c4250dc8cf62a26f846
      );

      return RepositoryResponse.succeed(response);
    } on DioError catch (error) {
      return RepositoryResponse.failed(error);
    } finally {
      _status = RepositoryStatus.completed;
    }
  }

  @override
  Future<RepositoryResponse> update(requestData) async {
    try {
      _status = RepositoryStatus.requesting;

      final apiRoutePath = '/usersHasTasksById';
      final response = await MainApiProvider.private.put(
        apiRoutePath,
        data: {
          "user_id": sessionUser.userData.id,
          "task_id": requestData['taskId'],
          "push_notification": "1",
          "period": requestData['periodSet'],
          "schedule": requestData['scheduleTime'],
        },
      );

      return RepositoryResponse.succeed(response);
    } on DioError catch (error) {
      return RepositoryResponse.failed(error);
    } finally {
      _status = RepositoryStatus.completed;
    }
  }

  @override
  Future<RepositoryResponse> destroy(requestData) async {
    try {
      _status = RepositoryStatus.requesting;

      final apiRoutePath = '/usersHasTasksById';
      final response = await MainApiProvider.private.delete(
        apiRoutePath,
        data: {
          "user_id": sessionUser.userData.id,
          "task_id": requestData['taskId'],
        },
      );

      return RepositoryResponse.succeed(response);
    } on DioError catch (error) {
      return RepositoryResponse.failed(error);
    } finally {
      _status = RepositoryStatus.completed;
    }
  }
}

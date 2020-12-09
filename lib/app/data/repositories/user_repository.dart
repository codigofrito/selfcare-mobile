import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:selfcare/app/data/interfaces/repository_interface.dart';
import 'package:selfcare/app/data/models/task_model.dart';
import 'package:selfcare/app/data/providers/main_api.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';

class UserRepository implements MainApiRepository<Task> {
  RepositoryStatus _status = RepositoryStatus.none;
  SessionUser sessionUser = Get.find<SessionUser>();

  @override
  RepositoryStatus get status => this._status;

  @override
  Future<RepositoryResponse> store(requestData) async {
    try {
      _status = RepositoryStatus.requesting;

      final apiRoutePath = '/users';
      final response = await MainApiProvider.private.post(
        apiRoutePath,
        data: {
          "id": requestData['userFirebaseId'],
          "name": requestData['displayName'],
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
  Future<RepositoryResponse> destroy(requestData) {
    // TODO: implement destroy
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResponse> index({requestData}) {
    // TODO: implement index
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResponse> show(requestData) {
    // TODO: implement show
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResponse> update(requestData) {
    // TODO: implement update
    throw UnimplementedError();
  }
}

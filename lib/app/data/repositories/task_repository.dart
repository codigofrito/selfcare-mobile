import 'package:dio/dio.dart';
import 'package:selfcare/app/data/interfaces/repository_interface.dart';
import 'package:selfcare/app/data/models/task_model.dart';
import 'package:selfcare/app/data/providers/main_api.dart';

class TaskRepository
    implements MainApiRepository<Task> {
  RepositoryStatus _status = RepositoryStatus.none;

  @override
  RepositoryStatus get status => this._status;

  Future<RepositoryResponse> index({requestData}) async {
    try {
      _status = RepositoryStatus.requesting;

      final apiRoutePath = '/tasks';
      final response = await MainApiProvider.private.get(
        apiRoutePath,
      );

      return RepositoryResponse.succeed(response);
    } on DioError catch (error) {
      return RepositoryResponse.failed(error);
    } finally {
      _status = RepositoryStatus.completed;
    }
  }

  @override
  Future<RepositoryResponse> destroy({requestData}) {
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResponse> show({requestData}) {
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResponse> store({requestData}) {
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResponse> update({requestData}) {
    throw UnimplementedError();
  }
}

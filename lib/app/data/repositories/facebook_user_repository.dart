import 'package:dio/dio.dart';
import 'package:selfcare/app/data/interfaces/repository_interface.dart';
import 'package:selfcare/app/data/providers/graph_api.dart';

class FacebookUserRepository extends DefaultRepository {
  RepositoryStatus _status = RepositoryStatus.none;

  @override
  RepositoryStatus get status => _status;

  Future<RepositoryResponse> show({requestData}) async {
    _status = RepositoryStatus.requesting;

    try {
      final apiRoutePath =
          '/v2.7//me?fields=name,first_name,last_name,email,picture.type(large)&access_token=${requestData['token']}';
      final response = await GraphApiProvider.public.get(apiRoutePath);

      return RepositoryResponse.succeed(response);
    } on DioError catch (error) {
      return RepositoryResponse.failed(error);
    } finally {
      _status = RepositoryStatus.completed;
    }
  }
}

import 'package:dio/dio.dart';
import 'dart:convert';

abstract class MainApiRepository<D> {
  RepositoryStatus get status;
  Future<RepositoryResponse> index({dynamic requestData});
  Future<RepositoryResponse> show({dynamic requestData});
  Future<RepositoryResponse> store({dynamic requestData});
  Future<RepositoryResponse> update({dynamic requestData});
  Future<RepositoryResponse> destroy({dynamic requestData});
}
abstract class DefaultRepository<D> {
  RepositoryStatus get status;
}

enum RepositoryStatus {
  none,
  requesting,
  completed,
}

class RepositoryResponse {
  Response _response;
  DioError _error;

  RepositoryResponse.succeed(Response response)
      : assert(response != null),
        this._response = response;

  RepositoryResponse.failed(DioError error)
      : assert(error != null),
        this._error = error;

  bool get hasError => _error != null;

  dynamic get raw => _response;

  DioErrorType get errorType => _error?.type;

  Map<String, dynamic> get data => json.decode(raw.toString());

  DioError get error => _error;

  Map<String, dynamic> toMap() {
    return {
      'hasError': this.hasError,
      'errorType': this.errorType,
      'data': this.data,
    };
  }
}

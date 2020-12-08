// import 'package:dio/dio.dart';
// import 'package:selfcare/app/data/interfaces/repository_interface.dart';

// class UserRepository {

//   RepositoryStatus _status = RepositoryStatus.none;

//   @override
//   RepositoryStatus get status => this._status;

//   Future<RepositoryResponse> signIn({requestData}) async {
//     try {
//       this._status = RepositoryStatus.requesting;

//       final apiRoutePath = '/login';
//       final response = await MainApiProvider.public.post(
//         apiRoutePath,
//         data: {
//           'cpfNumber': requestData.cpfNumber,
//           'password': requestData.password,
//         },
//       );

//       return RepositoryResponse.succeed(response);
//     } on DioError catch (error) {
//       return RepositoryResponse.failed(error);
//     } finally {
//       this._status = RepositoryStatus.completed;
//     }
//   }

//   Future<RepositoryResponse> verifyCredentials({requestData}) async {
//     try {
//       final apiRoutePath = '/verifyCredentials';
//       final response = await MainApiProvider.public.post(
//         apiRoutePath,
//         data: {
//           'cpfNumber': requestData.cpfNumber,
//           'password': requestData.password,
//         },
//       );

//       return RepositoryResponse.succeed(response);
//     } on DioError catch (error) {
//       return RepositoryResponse.failed(error);
//     } finally {
//       this._status = RepositoryStatus.completed;
//     }
//   }

//   Future<RepositoryResponse> update({requestData}) async {

//     print(requestData['googleId']);
//     try {
//       final apiRoutePath = '/system/user/update';
//       final response = await MainApiProvider.public.post(
//         apiRoutePath,
//         data: {
//           'cpfNumber': requestData['cpfNumber'],
//           'email': requestData['email'] ?? null,
//           'googleId': requestData['googleId'] ?? null,
//           'facebookId': requestData['facebookId'] ?? null,
//           'isActive': requestData['isActive'] ?? null,
//         },
//       );

//       return RepositoryResponse.succeed(response);
//     } on DioError catch (error) {
//       return RepositoryResponse.failed(error);
//     } finally {
//       this._status = RepositoryStatus.completed;
//     }
//   }

//   Future<RepositoryResponse> signInWithSocialNetwork(
//       {String socialNetwork, String accessToken}) async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     try {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       this._status = RepositoryStatus.requesting;

//       final apiRoutePath = '/loginWithSocialNetwork';
//       final response = await MainApiProvider.public.post(
//         apiRoutePath,
//         data: {
//           'socialNetwork': socialNetwork,
//           'accessToken': accessToken,
//           'origin': androidInfo.model
//         },
//       );

//       return RepositoryResponse.succeed(response);
//     } on DioError catch (error) {
//       return RepositoryResponse.failed(error);
//     } finally {
//       this._status = RepositoryStatus.completed;
//     }
//   }

//   Future<RepositoryResponse> signOut() async {
//     try {
//       final apiRoutePath = '/logout';
//       final response = await MainApiProvider.bearer.post(
//         apiRoutePath,
//       );
//       return RepositoryResponse.succeed(response);
//     } on DioError catch (error) {
//       return RepositoryResponse.failed(error);
//     } finally {
//       this._status = RepositoryStatus.completed;
//     }
//   }

//   Future<RepositoryResponse> checkTokenValidation() async {
//     try {
//       final apiRoutePath = '/check';
//       final response = await MainApiProvider.bearer.post(
//         apiRoutePath,
//       );
//       return RepositoryResponse.succeed(response);
//     } on DioError catch (error) {
//       return RepositoryResponse.failed(error);
//     } finally {
//       this._status = RepositoryStatus.completed;
//     }
//   }

//   @override
//   Future<RepositoryResponse> index({requestData}) {
//     throw UnimplementedError();
//   }
// }

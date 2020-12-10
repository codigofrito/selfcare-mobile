import 'package:get/get.dart';
import 'package:selfcare/app/data/models/user_model.dart';
import 'package:selfcare/app/data/models/user_task.dart';
import 'package:selfcare/app/data/session_config/local_storage.dart';
import 'package:selfcare/app/data/repositories/user_repository.dart';

class SessionUser {
  bool _isLogged;
  User _userData;
  RxList<UserTask> _userTasks;

  List<UserTask> get userTaskList => _userTasks;

  SessionUser()
      : this._isLogged = false,
        this._userData = User(),
        this._userTasks = <UserTask>[].obs;

  bool get isLogged => _isLogged;
  User get userData => this._userData;

  Future<bool> signIn(
    String displayName,
    String userFirebaseId,
    String userUrlPhoto,
  ) async {
    this._isLogged = true;
    this._userData = User(
      displayName,
      userFirebaseId,
      userUrlPhoto,
    );

    await UserRepository()
        .store(User(displayName, userFirebaseId))
        .then((response) => print(response));

    await LocalStorage.setUserData(this._userData);
    return true;
  }

  Future<void> signInFromLocalStorage() async {
    User user = await LocalStorage.getLastSession();
    if (user != null)
      this.signIn(
        user.name,
        user.id,
        user.userUrlPhoto,
      );
    await LocalStorage.setUserData(this._userData);
  }

  Future<void> sigOut() async {
    LocalStorage.clearSession();
    _isLogged = false;
    _userData = User();
  }
}

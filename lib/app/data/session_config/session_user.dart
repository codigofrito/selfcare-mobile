import 'package:get/get.dart';
import 'package:selfcare/app/data/models/user_model.dart';
import 'package:selfcare/app/data/models/user_task.dart';

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
      String displayName, String userFirebaseId, String userUrlPhoto) async {
    _isLogged = true;
    _userData = User(
      displayName,
      userFirebaseId,
      userUrlPhoto,
    );
    return true;
  }

  Future<void> signInFromLocalStorage() async {}

  Future<void> sigOut() async {
    _isLogged = false;
    _userData = User();
  }
}

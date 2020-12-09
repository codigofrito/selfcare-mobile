import 'package:selfcare/app/data/interfaces/data_model_interface.dart';

class User implements DataModel {
  User([
    String name,
    String id,
    String userUrlPhoto,
  ])  : this._name = name,
        this._id = id,
        this._userUrlPhoto = userUrlPhoto;

  User.fromJson(Map<String, dynamic> json) {
    this.fromJson(json);
  }

  String _id;
  String _name;
  String _userUrlPhoto;

  String get id => this._id;
  String get name => this._name;
  String get userUrlPhoto => this._userUrlPhoto;

  @override
  void fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this._id = json['id'];
      this._name = json['name'];
      this._userUrlPhoto = json['userUrlPhoto'];
    }
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this._id,
      'name': this._name,
      'userUrlPhoto': this._userUrlPhoto,
    };
  }
}

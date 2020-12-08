import 'package:selfcare/app/data/interfaces/data_model_interface.dart';

class User implements DataModel {
  String id;
  String name;
  String userUrlPhoto;

  User([String name, String id, String userUrlPhoto])
      : this.name = name ?? null,
        this.id = id ?? null,
        this.userUrlPhoto = userUrlPhoto ?? null;

  @override
  fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}

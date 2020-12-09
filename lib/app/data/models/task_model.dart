import 'package:selfcare/app/data/interfaces/data_model_interface.dart';

class Task implements DataModel {
  String id;
  String title;
  String description;
  String imageUrl;
  String createdAt;
  String updatedAt;

  Task({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  Task.fromJson(Map<String, dynamic> json) {
    this.fromJson(json);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    id = json['id'] != null
        ? json['id'].toString()
        : json['task_id'] != null ? json['task_id'].toString() : null;
    title = json['title'] ?? json['titulo'];
    description = json['description'] ?? json['descricao'];
    imageUrl = json['image_url'] ?? json['img'];
    createdAt = json['created_at'] == null ? "" : json['created_at'].toString();
    updatedAt = json['updated_at'] == null ? "" : json['updated_at'].toString();
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

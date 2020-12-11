import 'package:selfcare/app/data/interfaces/data_model_interface.dart';
import 'package:selfcare/app/data/models/task_model.dart';

class UserTask implements DataModel {
  Set<int> period;
  String schedule;
  Task task;

  UserTask({this.period, this.schedule, this.task});

  @override
  fromJson(Map<String, dynamic> json) {
    period = json['period'].toString().split(",").map(int.parse).toSet();
    schedule = json['schedule'].toString();
    task = json['task'] != null ? new Task.fromJson(json['task']) : null;
  }

  UserTask.fromJson(Map<String, dynamic> json) {
    this.fromJson(json);
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period'] = this.period;
    data['schedule'] = this.schedule;
    if (this.task != null) {
      data['task'] = this.task.toMap();
    }
    return data;
  }
}

import 'package:osm_flutter/app/task_tab/domain/respones/get_recent_task_response_model.dart';
import 'package:osm_flutter/utils/utils.dart';

class CreateTaskListModel{
  String? date;
  String? time;
  List<TaskList>? testList;
  List<CreateTaskDataModel>? list;

  CreateTaskListModel({this.time,this.date,this.list,this.testList});
}



class CreateTaskDataModel {
  String? profilePic;
  String? dashboardName;
  String? title;
  String? time;
  String? name;
  String? date;
  String? fullTime;
  num? messageCount;
  CreateTaskDataModel({this.profilePic,this.dashboardName,this.title,this.time,this.name,this.date,this.fullTime,this.messageCount});


}
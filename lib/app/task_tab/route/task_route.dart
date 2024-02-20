import 'package:flutter/material.dart';
import 'package:osm_flutter/app/home_tab/view/home_tab_page.dart';
import 'package:osm_flutter/app/task_tab/view/create_task_page.dart';
import 'package:osm_flutter/app/task_tab/view/task_tab_page.dart';

import '../view/update_task_and_details_page.dart';

class TaskRoute{

  static String route = "/task_bar";
  static String createTaskRoute = "/crete_task";
  static String updateTaskRoute = "/update_task";

  static Widget get child => const TaskTabPage();
  static Widget get createTaskChild => const CreateTaskPage();
  static Widget get updateTaskChild => const UpdateTaskAndDetails();

  static goToTaskPage(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }

  static goToCreteTaskPage(BuildContext context) {
    Navigator.of(context).pushNamed(createTaskRoute);
  }

  static goToUpdateTaskPage(BuildContext context,int? id){
    Navigator.of(context).pushNamed(updateTaskRoute,arguments: id);
  }

}
class TaskUpdateModel{
  bool? isUpdate;
  int? id;
  TaskUpdateModel({this.isUpdate,this.id});

}
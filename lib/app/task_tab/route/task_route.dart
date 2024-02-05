import 'package:flutter/material.dart';
import 'package:osm_flutter/app/home_tab/view/home_tab_page.dart';
import 'package:osm_flutter/app/task_tab/view/task_tab_page.dart';

class TaskRoute{
  static String route = "/task_bar";
  static Widget get child => const TaskTabPage();
  static goToTaskPage(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }

}
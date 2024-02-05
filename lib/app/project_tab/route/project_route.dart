import 'package:flutter/material.dart';
import 'package:osm_flutter/app/home_tab/view/home_tab_page.dart';
import 'package:osm_flutter/app/project_tab/view/project_tab_page.dart';

class ProjectRoute{
  static String route = "/project_bar";
  static Widget get child => const ProjectTabPage();
  static goToProjectScreen(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }

}
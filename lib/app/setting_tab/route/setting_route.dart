import 'package:flutter/material.dart';
import 'package:osm_flutter/app/home_tab/view/home_tab_page.dart';
import 'package:osm_flutter/app/setting_tab/view/setting_tab_page.dart';
import 'package:osm_flutter/app/task_tab/view/task_tab_page.dart';

class SettingRoute{
  static String route = "/setting_bar";
  static Widget get child => const SettingTabPage();
  static goToSettingPage(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }

}
import 'package:flutter/material.dart';
import 'package:osm_flutter/app/home_tab/view/home_tab_page.dart';

class HomeRoute{
  static String route = "/home_bar";
  static Widget get child => const HomeTabPage();
  static goToHomeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }

}
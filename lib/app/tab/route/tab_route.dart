import 'package:flutter/material.dart';
import 'package:osm_flutter/app/tab/view/tab_screen.dart';

class TabRoute{
  static String route = "/tab_bar";
  static Widget get child => const TabScreen();
  static goToTabBarScreen(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }

}
import 'package:flutter/material.dart';

import '../view/lending_screen.dart';


class LendingRoute{
  static String route = "/";

  static Widget get child => const LendingPage();

  static goToLoginPage(BuildContext context) {
    Navigator.of(context).pushNamed(route);
  }
}
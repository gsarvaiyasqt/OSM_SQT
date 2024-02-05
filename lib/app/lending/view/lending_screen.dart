import 'dart:io';
import 'package:flutter/material.dart';
import 'package:osm_flutter/app/auth/view/login_screen.dart';
import 'package:osm_flutter/app/tab/view/tab_screen.dart';
import 'package:provider/provider.dart';
import '../../../base/base.dart';
import '../../../base/view/base_components/custom_option_bottom_sheet.dart';
import '../../auth/view/splash_screen.dart';
import '../view_model/lending_provider.dart';




class LendingPage extends StatefulWidget {
  const LendingPage({Key? key}) : super(key: key);

  @override
  State<LendingPage> createState() => _LendingPageState();
}

class _LendingPageState extends State<LendingPage> {

  bool lendingProvider = false;
  bool underMaintenance = false;

  UserPrefs userPrefs = UserPrefs();


  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toaster.showMessage(context,  msg: "Press again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final lendingProvider = context.watch<LendingProvider>();
    print("LOGINN ==== ${lendingProvider.isLogin}");


    if(lendingProvider.isLogin == false) {

      return const LoginScreen();

    }

    if(lendingProvider.isLogin == true) {

      return const TabScreen();

    }

    return const SplashScreen();

  }
}

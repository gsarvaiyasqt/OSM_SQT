import 'dart:io';
import 'package:flutter/material.dart';
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




    // if(lendingProvider.isLogin == false) {
    //
    //   return const LoginScreen();
    //
    // }else if(lendingProvider.isLogin == true) {
    //
    //   return FirebaseMessagingHandler(onNotificationClick: (data) {
    //     print("data ${data}");
    //   },
    //   child: WillPopScope(
    //     onWillPop: onWillPop,
    //       child: const DashboardScreen()));
    // }

    return const SplashScreen();

  }
}

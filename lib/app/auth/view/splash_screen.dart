import 'dart:async';

import 'package:flutter/material.dart';
import 'package:osm_flutter/app/auth/route/auth_route.dart';
import 'package:osm_flutter/app/auth/view/login_screen.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void goToLoginPage()async{
    await Future.delayed(Duration(seconds: 3),() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    },);
  }

  @override

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      goToLoginPage();
    });
  }
  @override
  Widget build(BuildContext context) {
    print("SPLASH SCREEN");
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 72.sp,
                width: 280.sp,
                child: ImageUtil.logo.appLogo,
              ),
            )
          ],
        ),
      ),
    );
  }
}

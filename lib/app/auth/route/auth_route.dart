import 'package:flutter/material.dart';
import 'package:osm_flutter/app/auth/view/change_password_screen.dart';
import 'package:osm_flutter/app/auth/view/forgot_password_screen.dart';
import 'package:osm_flutter/app/auth/view/login_screen.dart';
import 'package:osm_flutter/app/auth/view/otp_screen.dart';
import 'package:osm_flutter/app/auth/view/splash_screen.dart';

class AuthRoute{

  static String splashRoute = "/splash";
  static String loginRoute = "/login";
  static String forgotRoute = "/forgot";
  static String otpRoute = "/otp";
  static String changePasswordRoute = "/changePassword";

  static Widget get splashChild => const SplashScreen();
  static Widget get loginChild => const LoginScreen();
  static Widget get forgotChild => const ForgotPasswordScreen();
  static Widget get otpChild => const OtpScreen();
  static Widget get changePasswordChild => const ChangePasswordScreen();

  static goToSplashPage(BuildContext context){
    Navigator.of(context).pushNamed(splashRoute);
  }

  static goToLoginPage(BuildContext context){
    Navigator.of(context).pushNamed(loginRoute);
  }

  static goToForgotPage(BuildContext context){
    Navigator.of(context).pushNamed(forgotRoute);
  }

  static goToOtpPage(BuildContext context){
    Navigator.of(context).pushNamed(otpRoute);
  }

  static goToChangePasswordPage(BuildContext context){
    Navigator.of(context).pushNamed(changePasswordRoute);
  }

}
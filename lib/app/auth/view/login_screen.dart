import 'package:flutter/material.dart';
import 'package:osm_flutter/app/auth/route/auth_route.dart';
import 'package:osm_flutter/app/auth/view/forgot_password_screen.dart';
import 'package:osm_flutter/base/view/base_components/custom_button.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool passwordShow = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo/logo.png",
                    height: 60.sp,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 75.sp,),
                  CustomTextField(
                    name: "Email",
                    isOptional: false,
                    hint: "Email",
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    suffix: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 19.sp,
                            width: 19.sp,
                            child: ImageUtil.iconImageClass.mailIcon),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.sp,),

                  CustomTextField(
                    isOptional: false,
                    name: "Password",
                    isSecure: passwordShow,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordShow = !passwordShow;
                        });
                      },
                      child: passwordShow ?  Icon(Icons.visibility,size: 25.sp,color: kBlackColor,) : Icon(Icons.visibility_off,size: 25.sp,color: kBlackColor,),
                    ),
                    hint: "Password",
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                  ),

                  GestureDetector(
                    onTap: () {
                      AuthRoute.goToForgotPage(context);
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Forgot password?",style: CustomTextStyle.blueRegularFont16Style,)),
                  ),

                  SizedBox(height: 50.sp,),

                  CustomButton(
                    onTap: () {
                      print("formKey.currentState?.validate() ${formKey.currentState?.validate()}");
                      if(formKey.currentState?.validate() == true){
                        print("Login");
                      }
                    },
                    btnText: "Login",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

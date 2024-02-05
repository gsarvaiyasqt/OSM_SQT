import 'package:flutter/material.dart';
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo/logo.png",
              height: 60.sp,
              width: 232.sp,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 75.sp,),
            CustomTextField(
              hint: "Email",
              controller: emailController,
              textInputAction: TextInputAction.next,
            ),

            SizedBox(height: 15.sp,),

            CustomTextField(
              hint: "Password",
              controller: passwordController,
              textInputAction: TextInputAction.next,
            ),
            
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
              },
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot password?",style: CustomTextStyle.blueRegularFont16Style,)),
            ),

            SizedBox(height: 50.sp,),

            CustomButton(
              btnText: "Login",
            )
          ],
        ),
      ),
    );
  }
}

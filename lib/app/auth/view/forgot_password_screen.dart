import 'package:flutter/material.dart';
import 'package:osm_flutter/base/view/base_components/custom_button.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: CustomTextStyle.regularFont22Style,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 35.sp, vertical: 36.sp),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: kLightWhiteColor),
                child: Image.asset(
                  "assets/images/bg_img/forgot.png",
                  height: 75.sp,
                  width: 95.sp,
                  fit: BoxFit.contain,
                )),

            SizedBox(height: 30.sp,),

            Text(
              "Please Enter your Email address to\nrecieve a Verificatio Code",
              textAlign: TextAlign.center,
              style: CustomTextStyle.regularFont16Style
                  .copyWith(color: kBlackColor.withOpacity(0.50)),
            ),

            SizedBox(height: 45.sp,),

            CustomTextField(
              hint: "Email",
            ),

            SizedBox(height: 50.sp,),

            CustomButton(
              btnText: "Send",
            )
          ],
        ),
      ),
    );
  }
}

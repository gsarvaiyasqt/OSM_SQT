import 'package:flutter/material.dart';
import 'package:osm_flutter/app/auth/route/auth_route.dart';
import 'package:osm_flutter/base/view/base_components/custom_button.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  bool passwordShow = false;
  bool confirmPasswordShow = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a New Password",style: CustomTextStyle.regularFont22Style),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  Container(
                    padding: EdgeInsets.all(35.sp),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kLightWhiteColor
                    ),
                    child: SizedBox(
                      height: 100.sp,
                      width: 104.sp,
                      child: ImageUtil.backgroundImage.createPassword,
                    ),
                  ),

                  SizedBox(height: 30.sp,),

                  CustomTextField(
                    isOptional: false,
                    name: "password",
                    isSecure: !passwordShow ? true : false,
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

                  SizedBox(height: 15.sp,),

                  CustomTextField(
                    isOptional: false,
                    name: "Confirm Password",
                    isSecure: !confirmPasswordShow ? true : false,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          confirmPasswordShow = !confirmPasswordShow;
                        });
                      },
                      child: confirmPasswordShow ?  Icon(Icons.visibility,size: 25.sp,color: kBlackColor,) : Icon(Icons.visibility_off,size: 25.sp,color: kBlackColor,),
                    ),
                    hint: "Confirm Password",
                    controller: confirmPasswordController,
                    textInputAction: TextInputAction.done,
                  ),

                  SizedBox(height: 50.sp,),

                  CustomButton(
                    btnText: "Save",
                    onTap: () {
                      if(formKey.currentState?.validate() == true){
                        AuthRoute.goToLoginPage(context);
                      }
                    },
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

import 'package:flutter/material.dart';
import 'package:osm_flutter/app/auth/route/auth_route.dart';
import 'package:osm_flutter/app/auth/view/forgot_password_screen.dart';
import 'package:osm_flutter/app/auth/view_model/auth_provider.dart';
import 'package:osm_flutter/app/lending/domain/ui_state/set_add_state_model.dart';
import 'package:osm_flutter/app/lending/view_model/lending_provider.dart';
import 'package:osm_flutter/app/tab/route/tab_route.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/base/view/base_components/custom_button.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../tab/view/tab_screen.dart';

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
    final authProvider = context.watch<AuthProvider>();
    final loginData = authProvider.loginResponse.data?.data;
    final lendingProvider = context.read<LendingProvider>();
    final isLoading = authProvider.loginResponse.state == Status.LOADING;
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                      isLoading: isLoading,
                      onTap: () async{
                        if(formKey.currentState?.validate() == true){
                          try {
                            await context.read<AuthProvider>().login(userName: emailController.text, password: passwordController.text);

                            final loginData = authProvider.loginResponse.data?.data;

                            var responseModel = SetAddStateModel(
                              userId: loginData?.userData?[0].userId,
                              associationId: loginData?.userData?[0].associationId,
                              token: loginData?.accesstoken
                            );
                            print("user Id :- ${loginData?.userData?[0].userId}");
                            await lendingProvider.setAppState(responseModel);
                            Navigator.popUntil(context, (route) => route.isFirst);
                          } catch (e) {
                            print("error ===== $e");
                            Toaster.showMessage(context, msg: e.toString(),isError: true);
                          }
                        }
                      },
                      btnText: "Login",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

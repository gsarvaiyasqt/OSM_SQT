import '../../../base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:osm_flutter/app/auth/view_model/auth_provider.dart';
import 'package:osm_flutter/base/view/base_components/custom_button.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: CustomTextStyle.regularFont22Style,
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 35.sp, vertical: 36.sp),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: kLightWhiteColor),
                      child: SizedBox(
                          height: 80.sp,
                          width: 80.sp,
                          child: ImageUtil.backgroundImage.forgot)),

                  SizedBox(height: 30.sp,),

                  Text(
                    "Please Enter your Email address to\nrecieve a Verificatio Code",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.regularFont16Style
                        .copyWith(color: kBlackColor.withOpacity(0.50)),
                  ),

                  SizedBox(height: 45.sp,),

                  CustomTextField(
                    controller: emailController,
                    regex: StringValidation.emailValidation,
                    isOptional: false,
                    name: "Email Address",
                    hint: "Email",
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

                  SizedBox(height: 50.sp,),

                  CustomButton(
                    btnText: "Send",
                    isLoading: authProvider.sendOtpWithoutAuthResponse.state == Status.LOADING,
                    onTap: () async{
                      FocusManager.instance.primaryFocus?.unfocus();

                      HapticFeedback.heavyImpact();

                      final isFormValid = formKey.currentState?.validate();
                      final navigation = Navigator.of(context);

                      if(isFormValid == false) return;

                      try {

                        final authProvider = context.read<AuthProvider>();

                        await authProvider.forgotPassword(email: emailController.text);

                        navigation.pop();

                        Toaster.showMessage(context, msg: "Your Mail Sent Successfully",isError: false);

                      } catch (e) {

                        Toaster.showMessage(context, msg: e.toString(),isError: true);

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

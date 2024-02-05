import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osm_flutter/app/auth/route/auth_route.dart';
import 'package:osm_flutter/base/view/base_components/custom_button.dart';

import '../../../utils/utils.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Email",style: CustomTextStyle.regularFont22Style),
      ),
      body: Padding(
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
                        child: ImageUtil.backgroundImage.verify)),

                SizedBox(height: 30.sp,),

                Text(
                  "Please Enter the 4 Digit Code Sent to\nsoftqu******gmail.com",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.regularFont16Style
                      .copyWith(color: kBlackColor.withOpacity(0.50)),
                ),

                SizedBox(height: 45.sp,),

                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4 ?? 0, (index) {
                        var myValue = (otpController.text.isNotEmpty && otpController.text.length >= index + 1)
                            ? otpController.text[index]
                            : "";
                        return Container(
                          margin: EdgeInsets.only(right: 12.sp),
                          child: Column(
                            children: [
                              Text(myValue,style: CustomTextStyle.regularFont28Style,),
                              Container(
                                margin: EdgeInsets.only(top: 5.sp),
                                height: 3.sp,
                                decoration: BoxDecoration(
                                  color: kBlueColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5.sp),
                                    bottomRight: Radius.circular(5.sp)
                                  )
                                ),
                                width: 54.sp,
                              )
                            ],
                          ),
                        );
                        return Container(
                          height: 54.sp,
                          width: 54.sp,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2.sp,color: const Color(0xffCCCCCC)),
                          ),
                          child: Center(
                            child: Text(myValue ?? "",style: CustomTextStyle.boldFont24Style.copyWith(
                                fontWeight: FontWeight.w400
                            )),
                          ),
                        );
                      }),
                    ),
                    TextFormField(
                      autofillHints: [
                        AutofillHints.oneTimeCode,
                      ],
                      controller: otpController,
                      style: const TextStyle(color: Colors.transparent),
                      cursorColor: Colors.transparent,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4)
                      ],
                      onChanged: (value) {
                        setState(() {
                          // if(value.length < 4){
                          //   error = "Please Enter Valid OTP";
                          // }else{
                          //   error = "";
                          // }



                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counterText: '',
                        hoverColor: Colors.transparent,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusColor: Colors.transparent,
                        fillColor: Colors.transparent,
                        filled: false,
                        focusedBorder: InputBorder.none,
                        alignLabelWithHint: false,
                        focusedErrorBorder: InputBorder.none,
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    )
                  ],
                ),

                SizedBox(height: 50.sp,),

                Text("Resend Code",style: CustomTextStyle.blueSemiBoldFont16Style.copyWith(fontSize: 24.sp,decoration: TextDecoration.underline,decorationThickness: 2.sp,),),

                SizedBox(height: 50.sp,),

                CustomButton(
                  onTap: () {
                    AuthRoute.goToChangePasswordPage(context);
                  },
                  btnText: "Verify",
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

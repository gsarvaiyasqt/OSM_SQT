import '../../../utils/utils.dart';
import 'package:flutter/material.dart';

class ImagePlaceHolder extends StatelessWidget {
  final Widget? child;
  final bool? isLoading;
  const ImagePlaceHolder({super.key,this.child, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

       Positioned(bottom: 0,left: 0,right: 0,top: 0,child: Container(
         height: 184.sp,
         decoration: BoxDecoration(
            color: Colors.white,
             borderRadius: BorderRadius.circular(100),
           boxShadow: [
             BoxShadow(
               offset: Offset(0,0),
               color: kPrimaryColor.withOpacity(0.30),
               blurRadius: 50.sp,
               spreadRadius:0

             )
           ]

         ),
         padding: EdgeInsets.all(2.sp),
         child: child ??
             Container(
               height: 182.sp,
           decoration: BoxDecoration(
             border: Border.all(color: Colors.black),
               borderRadius: BorderRadius.circular(100)
           ),
           child: ClipRRect(
               borderRadius: BorderRadius.circular(100),
               child: Icon(Icons.image,size: 50.sp,)
           ),
         ),
       )),

        if(isLoading == true)
          const Positioned(bottom: 0,left: 0,right: 0,top: 0,child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),

          )),

        Positioned(
          bottom: 5.sp,right: 5.sp,
          child: Container(
            height: 40.sp,
            width: 40.sp,
            decoration: BoxDecoration(
              border: Border.all(color: kWhiteColor,width: 2),
              color: kTextSecondaryColor.withOpacity(0.2),
              shape: BoxShape.circle
            ),
              padding: EdgeInsets.all(3.sp),
              child: ImageUtil.iconImageClass.addIcon),)
      ],
    );
  }
}

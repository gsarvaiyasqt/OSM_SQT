import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
class UploadProfilePic extends StatefulWidget {
  final Function()? openCamera;
  final Function()? openGallery;
  const UploadProfilePic({Key? key, this.openCamera, this.openGallery}) : super(key: key);

  @override
  State<UploadProfilePic> createState() => _UploadProfilePicState();
}

class _UploadProfilePicState extends State<UploadProfilePic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      decoration: BoxDecoration(
        color: kWhiteColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30.sp),topLeft: Radius.circular(30.sp))
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.sp,),
            Center(
              child: Container(
                height: 4.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(40)
                ),
              ),
            ),
            SizedBox(height: 30.sp,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Upload Photo",style: CustomTextStyle.blackBoldFont20Style,),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 24.sp,width: 24.sp,
                    child: ImageUtil.iconImageClass.closeBottomSheetIcon,),
                )
              ],
            ),
            SizedBox(height: 10.sp,),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    widget.openGallery?.call();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(18.sp),
                     decoration: BoxDecoration(
                         color: kWhiteColor,
                         border: Border.all(color: kTextSecondaryColor.withOpacity(0.5)),
                         borderRadius: BorderRadius.circular(8)),
                    child: SizedBox(
                        width: 24.sp,height: 24.sp,
                        child: const Icon(Icons.photo)),
                  ),
                ),
                SizedBox(width: 10.sp),
                InkWell(
                  onTap: () {
                    widget.openCamera?.call();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(18.sp),
                     decoration: BoxDecoration(
                         color: kWhiteColor,
                         border: Border.all(color:kTextSecondaryColor.withOpacity(0.5)),
                         borderRadius: BorderRadius.circular(8)),
                    child: SizedBox(
                        width: 24.sp,height: 24.sp,
                        child: ImageUtil.iconImageClass.cameraIcon),
                  ),
                )
              ],
            ),
            SizedBox(height: 10.sp,),
          ],
        ),
      ),
    );
  }
}
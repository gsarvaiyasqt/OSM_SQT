import 'package:flutter/material.dart';
import 'package:osm_flutter/utils/utils.dart';
class CustomDropDownWidget extends StatelessWidget {
  final String? name;
  final String? selectedItem;
  final GestureTapCallback? onTap;
  const CustomDropDownWidget({Key? key, this.name, this.selectedItem, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.topLeft,
      children: [

        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.sp),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
               height: 50.sp,
               alignment: Alignment.centerLeft,
               width: double.infinity,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5.sp),
                 border: Border.all(
                   color: kBlackColor
                 )
               ),
              child: Padding(
                padding: EdgeInsets.only(right: 10.sp,left: 20.sp),
                child: Row(
                  children: [
                    Expanded(child: Text(selectedItem ?? "Select",style: CustomTextStyle.regularFont18Style)),
                    SizedBox(height: 24.sp,width: 24.sp,child: ImageUtil.iconImageClass.dropdownIcon)
                  ],
                ),
              ),
             ),
          ),
        ),
        Positioned(
            top: 0.sp,
            left: 23.sp,
            child: Container(
                color: kSecondaryBackgroundColor,
                child: Text(name ?? "",style: CustomTextStyle.lightFont16BlackStyle))),

      ],
    );
  }
}

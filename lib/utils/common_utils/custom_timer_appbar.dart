import 'package:flutter/material.dart';
import 'package:osm_flutter/utils/utils.dart';
class CustomTimerAppbar extends StatelessWidget implements PreferredSizeWidget{
  final double height;
  final Widget? lending;
  final String? titleText;
  final Widget? action;
  const CustomTimerAppbar({Key? key, required this.height, this.lending, this.titleText, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      color: kBlackColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(lending != null)
            SizedBox(
              height: 45.sp,
              width: 45.sp,
              child: lending,
            ),
          SizedBox(width: 10.sp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dashboard - OMS",style: CustomTextStyle.semiBoldFont16Style.copyWith(
                    color: kBackgroundColor.withOpacity(0.50)
                ),),
                Text(titleText ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.semiBoldFont18Style.copyWith(
                        color: kWhiteColor
                    ))
              ],
            ),
          ),
          SizedBox(width: 10.sp),
          if(action != null)
            action!

        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
import 'package:flutter/material.dart';
import 'package:osm_flutter/utils/common_utils/skeleton_loading.dart';
import 'package:osm_flutter/utils/utils.dart';
class CustomTimerAppbar extends StatelessWidget implements PreferredSizeWidget{
  final bool? loader;
  final double height;
  final Widget? lending;
  final String? titleText;
  final String? projectText;
  final Widget? action;
  const CustomTimerAppbar({Key? key, required this.height, this.lending, this.titleText, this.action, this.loader, this.projectText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      color: kBlackColor,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(lending != null)
              SkeletonView(
                isLoading: loader,
               borderRadius: BorderRadius.circular(8.sp),
               skeletonBody: SizedBox(
                   height: 45.sp,
                   width: 45.sp
               ),
                child: SizedBox(
                  height: 45.sp,
                  width: 45.sp,
                  child: lending,
                ),
              ),

            SizedBox(width: 10.sp),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkeletonView(
                    isLoading: loader,
                    borderRadius: BorderRadius.circular(8.sp),
                    skeletonBody: SizedBox(
                      width: 80.sp,
                      height: 16.sp,
                    ),
                    child: Text(projectText ?? "",style: CustomTextStyle.semiBoldFont16Style.copyWith(
                        color: kBackgroundColor.withOpacity(0.50)
                    ),),
                  ),
        
                  if(loader == true)
                  SizedBox(height: 10.sp),
        
                  SkeletonView(
                    isLoading: loader,
                    borderRadius: BorderRadius.circular(8.sp),
                    skeletonBody: SizedBox(
                      width: 120.sp,
                      height: 16.sp,
                    ),
                    child: Text(titleText ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.semiBoldFont18Style.copyWith(
                            color: kWhiteColor
                        )),
                  )
                ],
              ),
            ),

            SizedBox(width: 10.sp),
            if(action != null)
              action!
        
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
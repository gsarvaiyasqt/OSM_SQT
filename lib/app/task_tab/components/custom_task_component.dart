import 'package:flutter/material.dart';
import 'package:osm_flutter/app/auth/domain/dummy/create_task_response.dart';

import '../../../utils/utils.dart';

class CustomTaskComponent extends StatefulWidget {
  final CreateTaskListModel? taskData;
  const CustomTaskComponent({super.key, this.taskData});

  @override
  State<CustomTaskComponent> createState() => _CustomTaskComponentState();
}

class _CustomTaskComponentState extends State<CustomTaskComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 15.sp, vertical: 13.sp),
      margin: EdgeInsets.only(bottom: 10.sp),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.taskData?.date ?? ""),
              Text(widget.taskData?.time ?? ""),
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),

          Column(
            children: [
              ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    color: kPrimaryColor.withOpacity(0.10),
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.taskData?.list?.length ?? 0,
                itemBuilder: (context, dataIndex) {
                  final data = widget.taskData?.list?[dataIndex];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 40.sp,
                              width: 40.sp,
                              child: Image.asset(data?.profilePic ?? "")),
                          SizedBox(
                            width: 9.sp,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data?.dashboardName ?? "",
                                  style: CustomTextStyle
                                      .regularFont14Style
                                      .copyWith(
                                      color: kPrimaryColor
                                          .withOpacity(0.50)),
                                ),
                                Text(
                                  data?.title ?? "",
                                  style: CustomTextStyle
                                      .semiBoldFont16Style,
                                ),

                                SizedBox(height: 15.sp,),

                                Row(
                                  children: [

                                    SizedBox(
                                        height: 24.sp,
                                        child: ImageUtil.dummy.profileImage),

                                    SizedBox(width: 9.sp,),
                                    
                                    Expanded(child: Text(data?.name ?? "",style: CustomTextStyle.regularFont16Style.copyWith(color: kPrimaryColor.withOpacity(0.80)),)),

                                    SizedBox(
                                      height: 16.sp,
                                      child: ImageUtil.iconImageClass.doubleArrow,
                                    ),

                                    SizedBox(width: 10.sp,),
                                    
                                    Text(data?.time ?? "",style: CustomTextStyle.semiBoldFont16Style.copyWith(color: kPrimaryColor.withOpacity(0.80)),),

                                    SizedBox(width: 10.sp,),

                                    SizedBox(
                                      height: 18.sp,
                                      width: 18.sp,
                                      child:dataIndex.isEven ?  ImageUtil.iconImageClass.blueClockIcon : ImageUtil.iconImageClass.verifiedIcon,
                                    )
                                  ],
                                ),

                                SizedBox(height: 10.sp,),

                                Row(
                                  children: [
                                    SizedBox(
                                      height: 18.sp,
                                      width: 18.sp,
                                      child: ImageUtil.iconImageClass.threeCalenderIcon,
                                    ),

                                    SizedBox(width: 10.sp,),

                                    Text(data?.date ?? "",style: CustomTextStyle.regularFont16Style.copyWith(color: kPrimaryColor.withOpacity(0.80)),),

                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 12.sp),
                                      width: 1.sp,
                                      height: 14.sp,
                                      color: kPrimaryColor.withOpacity(0.80),
                                    ),

                                    // SizedBox(
                                    //   child: ImageUtil,
                                    // )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },),
            ],
          ),

        ],
      ),
    );
  }
}

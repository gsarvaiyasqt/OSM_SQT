import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/auth/domain/dummy/create_task_response.dart';
import 'package:provider/provider.dart';

import '../../../base/view/base_components/custom_image_view.dart';
import '../../../base/view/base_components/skeleton_loading.dart';
import '../../../utils/utils.dart';
import '../view_model/home_provider.dart';

class CustomRecentTaskComponent extends StatefulWidget {
  final CreateTaskListModel? taskData;
  const CustomRecentTaskComponent({super.key, this.taskData});

  @override
  State<CustomRecentTaskComponent> createState() => _CustomRecentTaskComponentState();
}

class _CustomRecentTaskComponentState extends State<CustomRecentTaskComponent> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final recentLoader = homeProvider.resentTaskResponse.state == Status.LOADING;

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

              SkeletonView(
                borderRadius: BorderRadius.circular(8.sp),
                isLoading: recentLoader,
                skeletonBody: SizedBox(
                  height: 14.sp,
                  width: 70.sp,
                ),
                child: Text(widget.taskData?.date ?? ""),
              ),

              SkeletonView(
                borderRadius: BorderRadius.circular(8.sp),
                isLoading: recentLoader,
                skeletonBody: SizedBox(
                  height: 16.sp,
                  width: 70.sp,
                ),
                child: Text("${widget.taskData?.time} hrs" ?? "",style: CustomTextStyle.semiBoldFont16Style),
              ),



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
                itemCount: widget.taskData?.testList?.length ?? 0,
                itemBuilder: (context, dataIndex) {

                  final data = widget.taskData?.testList?[dataIndex];

                  final hourTime = formattedTime(timeInSecond: data?.totalTimeInMinites ?? 0);
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                                height: 40.sp,
                                width: 40.sp,
                                child: CustomImageView(
                                  uri: data?.projectLogo ?? "",fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(
                            width: 9.sp,
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data?.projectName ?? "",
                                  style: CustomTextStyle.regularFont14Style.copyWith(
                                      color: kPrimaryColor.withOpacity(0.50)),
                                ),
                                Text(
                                  data?.title ?? "",
                                  style: CustomTextStyle.semiBoldFont16Style,
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 3.sp,
                          ),

                          SizedBox(
                              height: 16.sp,
                              child: priorityFunc(priority: data?.priority)
                          ),


                          SizedBox(
                            width: 10.sp,
                          ),

                          // Time Working
                          Text("$hourTime hrs",
                              style: CustomTextStyle.regularFont14Style.copyWith(color: kPrimaryColor)),

                          SizedBox(width: 10.sp),

                          SizedBox(
                              height: 24.sp,
                              width: 24.sp,
                              child: statusFunc(status: data?.status)
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

  Widget? priorityFunc({String? priority}){
    switch(priority){

      case "Normal":
        return ImageUtil.iconImageClass.normalIcon;

    case "Highest":
      return ImageUtil.iconImageClass.doubleArrow;

      case "High":
        return ImageUtil.iconImageClass.doubleArrow;

      case "Low":
        return ImageUtil.iconImageClass.downIcon;
    }

    return SizedBox.shrink();
  }
}

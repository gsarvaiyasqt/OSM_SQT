import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/auth/domain/dummy/create_task_response.dart';

import '../../../base/view/base_components/custom_image_view.dart';
import '../../../utils/utils.dart';

class CustomRecentTaskComponent extends StatefulWidget {
  final CreateTaskListModel? taskData;
  const CustomRecentTaskComponent({super.key, this.taskData});

  @override
  State<CustomRecentTaskComponent> createState() => _CustomRecentTaskComponentState();
}

class _CustomRecentTaskComponentState extends State<CustomRecentTaskComponent> {
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
                itemCount: widget.taskData?.testList?.length ?? 0,
                itemBuilder: (context, dataIndex) {
                  final data = widget.taskData?.testList?[dataIndex];
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 40.sp,
                              width: 40.sp,
                              child: CustomImageView(
                                uri: data?.projectLogo ?? "",fit: BoxFit.cover,
                              )),
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
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              height: 16.sp,
                              child: ImageUtil
                                  .iconImageClass.doubleArrow),
                          SizedBox(
                            width: 10.sp,
                          ),
                          // Time Working
                          Text(DateFormat("hh:mm").format(DateTime.now()) ?? "",
                              style: CustomTextStyle
                                  .regularFont14Style
                                  .copyWith(
                                  color: kPrimaryColor
                                      .withOpacity(0.50))),
                          SizedBox(
                            width: 26.sp,
                          )
                        ],
                      ),
                    ],
                  );
                },),
            ],
          ),

          /*  Column(
                          children: List.generate(
                              createTaskData.list?.length ?? 0, (dataIndex) {
                            final data = createTaskData.list?[dataIndex];
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 40.sp,
                                        width: 40.sp,
                                        child: ImageUtil.dummy.profileImage),
                                    SizedBox(
                                      width: 9.sp,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data?.time ?? "",
                                            style: CustomTextStyle
                                                .regularFont14Style
                                                .copyWith(
                                                    color: kPrimaryColor
                                                        .withOpacity(0.50)),
                                          ),
                                          Text(
                                            data?.dashboardName ?? "",
                                            style: CustomTextStyle
                                                .semiBoldFont16Style,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height: 16.sp,
                                        child: ImageUtil
                                            .iconImageClass.doubleArrow),
                                    SizedBox(
                                      width: 10.sp,
                                    ),
                                    Text(data?.time ?? "",
                                        style: CustomTextStyle
                                            .regularFont14Style
                                            .copyWith(
                                                color: kPrimaryColor
                                                    .withOpacity(0.50))),
                                    SizedBox(
                                      width: 26.sp,
                                    )
                                  ],
                                ),
                                createTaskData.list?.length !=
                                        createTaskData.list!.length - 1
                                    ? Divider()
                                    : SizedBox.shrink()
                              ],
                            );
                          }),
                        )*/
        ],
      ),
    );
  }
}

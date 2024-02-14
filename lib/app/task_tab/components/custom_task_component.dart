import 'package:intl/intl.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:osm_flutter/app/auth/domain/dummy/create_task_response.dart';
import 'package:osm_flutter/base/view/base_components/custom_image_view.dart';

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
      margin: EdgeInsets.only(bottom: 10.sp),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.taskData?.date ?? ""),
              Text("${widget.taskData?.time} hrs" ?? "",style: CustomTextStyle.semiBoldFont16Style),
            ],
          ),

          SizedBox(
            height: 10.sp,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 15.sp),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(15.sp),
            ),

            child: Column(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ClipRRect(
                              borderRadius: BorderRadius.circular(100.sp),
                              child: SizedBox(
                                  height: 40.sp,
                                  width: 40.sp,
                                  child: CustomImageView(uri: data?.projectLogo,fit: BoxFit.cover,)
                              ),
                            ),
                            
                            SizedBox(
                              width: 8.sp,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ),

                                  SizedBox(height: 10.sp,),

                                ],
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                // startOrStop();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.sp,vertical: 6.sp),
                                decoration: BoxDecoration(
                                  color: kBlueColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(true ? Icons.play_arrow : Icons.pause,size: 20.sp,color: Colors.white),
                              ),
                            ),

                          ],
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left:10.sp),
                          child: Row(
                            children: [

                              SizedBox(
                                  height: 24.sp,
                                  child: ImageUtil.dummy.profileImage
                              ),

                              SizedBox(width: 9.sp,),

                              Expanded(child: Text(data?.projectName ?? "",style: CustomTextStyle.regularFont16Style.copyWith(color: kPrimaryColor.withOpacity(0.80)),)),


                              SizedBox(
                                  height: 16.sp,
                                  child: priorityFunc(priority: data?.priority)
                              ),

                              SizedBox(width: 10.sp,),

                              Text(hourTime == 0 ? "-" :  hourTime,style: CustomTextStyle.semiBoldFont16Style.copyWith(color: kPrimaryColor.withOpacity(0.80)),),

                              SizedBox(width: 10.sp,),

                              SizedBox(
                                height: 18.sp,
                                width: 18.sp,
                                child: statusFunc(status: data?.status),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 10.sp,),

                        Padding(
                          padding:  EdgeInsets.only(left: 10.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              Row(
                                  children: [

                                  SizedBox(
                                    height: 18.sp,
                                    width: 18.sp,
                                    child: ImageUtil.iconImageClass.threeCalenderIcon,
                                  ),

                                  SizedBox(width: 10.sp,),

                                  Text(DateFormat.yMMMd().format(data?.startDate ?? DateTime.now()) ,style: CustomTextStyle.regularFont16Style.copyWith(color: kPrimaryColor.withOpacity(0.80)),),
                                ]
                              ),


                              Container(width: 1.sp,
                                height: 20.sp,
                                color: kPrimaryColor.withOpacity(0.80),
                                margin: EdgeInsets.symmetric(horizontal: 8.sp),
                              ),


                              Row(
                                children: [
                                  SizedBox(
                                    height: 18.sp,
                                    width: 18.sp,
                                    child: ImageUtil.iconImageClass.timeQuarterIcon,
                                  ),

                                  SizedBox(width: 5.sp,),

                                  Text(DateFormat.yMMMd().format(data?.dateRang ?? DateTime.now()) ,style: CustomTextStyle.regularFont16Style.copyWith(color: kPrimaryColor.withOpacity(0.80))),
                                ],
                              ),

                              SizedBox(width: 8.sp),

                              Row(
                                children: [
                                  SizedBox(
                                    height: 18.sp,
                                    width: 18.sp,
                                    child: ImageUtil.iconImageClass.messageIcon,
                                  ),

                                  SizedBox(width: 5.sp,),

                                  Text(data?.projectId.toString() ?? "",style: CustomTextStyle.regularFont16Style.copyWith(color: kPrimaryColor.withOpacity(0.80)),)
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";

    return "$minute:$second hrs";


  }
}

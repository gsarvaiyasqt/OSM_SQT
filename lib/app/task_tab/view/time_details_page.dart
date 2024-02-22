

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../base/view/base_components/custom_image_view.dart';
import '../domain/respones/GetListTaskDateWiseTimerAndUserTaskModel.dart';
class TimeDetailsPage extends StatefulWidget {
  const TimeDetailsPage({Key? key}) : super(key: key);

  @override
  State<TimeDetailsPage> createState() => _TimeDetailsPageState();
}

class _TimeDetailsPageState extends State<TimeDetailsPage> {


  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final timeList = taskProvider.timeList;

    for (var element in timeList) {

        element.userList?.forEach((fElement) {

          fElement.textEditingController?.text = "1";

          print("fElement.textEditingController?.text is ${fElement.textEditingController?.text}");

        });

    }

    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      body: ListView.builder(
        itemCount: timeList.length,
        itemBuilder: (context, index) {
        final timeListData =  timeList[index];

        return Container(
          margin: EdgeInsets.all(5.sp),
          padding: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text("Date : ",style: CustomTextStyle.boldFont14Style),
                  Text(timeListData.startDate ?? "",style: CustomTextStyle.regularFont14Style),
                ],
              ),
              SizedBox(height: 10.sp),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text("Total Time : ",style: CustomTextStyle.boldFont14Style),
                        Text(timeListData.totalMns.toString() ?? "",style: CustomTextStyle.regularFont14Style),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text("Client Time : ",style: CustomTextStyle.boldFont14Style),
                        Text(timeListData.totalMns.toString() ?? "",style: CustomTextStyle.regularFont14Style),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.sp),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, userDataIndex) {
                    final userData = timeListData.userList?[userDataIndex];
                    return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 35.sp,
                          height: 35.sp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CustomImageView(
                              uri: userData?.profilePic ?? "",fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        Expanded(child: Text(userData?.displayName ?? "",style: CustomTextStyle.boldFont14Style)),
                        SizedBox(width: 10.sp),
                        Text("10:00",style: CustomTextStyle.boldFont14Style),
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: kBlackColor.withOpacity(0.1)
                        )
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Start Date",style: CustomTextStyle.boldFont14Style),
                              SizedBox(height: 5.sp),
                              GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: kBlackColor.withOpacity(0.1)
                                          )
                                      ),
                                      child: Text(userData?.startTime != null ? DateFormat("dd/MM/yyyy").format(userData!.startTime!) : "_",style: CustomTextStyle.regularFont12Style))),
                              SizedBox(height: 5.sp),
                              Text("End Date",style: CustomTextStyle.boldFont14Style),
                              SizedBox(height: 5.sp),
                              GestureDetector(
                                  onTap: () {
                                    print("End Date:::::::::::::::::::::::::::");
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: kBlackColor.withOpacity(0.1)
                                          )
                                      ),
                                      child: Text(userData?.endTime != null ? DateFormat("dd/MM/yyyy").format(userData!.endTime!) : "_",style: CustomTextStyle.regularFont12Style,)))
                            ],
                          )),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Time",style: CustomTextStyle.boldFont14Style),
                              SizedBox(height: 5.sp),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: kBlackColor.withOpacity(0.1)
                                      )
                                  ),
                                  child: Text(userData?.startTime != null ? DateFormat.jms().format(userData!.startTime!) : "_",style: CustomTextStyle.regularFont12Style,)),
                              SizedBox(height: 5.sp),
                              Text("Time",style: CustomTextStyle.boldFont14Style),
                              SizedBox(height: 5.sp),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: kBlackColor.withOpacity(0.1)
                                      )
                                  ),
                                  child: Text(userData?.endTime != null ? DateFormat.jms().format(userData!.endTime!) : "_",style: CustomTextStyle.regularFont12Style,)),
                            ],
                          )),
                          Container(
                             padding: EdgeInsets.all(2.sp),
                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.sp),color: kBlackColor),
                             child: Icon(Icons.save,size: 25.sp,color: kWhiteColor,))
                        ],
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Container(
                      height: 35.sp,
                      // padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: userData?.textEditingController,
                        // cursorHeight: 12.sp,
                        style: CustomTextStyle.regularFont14Style,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: kBlackColor.withOpacity(0.1),width: 1.sp)
                            ),
                            focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1),
                                          width: 1.sp)),
                            enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: kBlackColor.withOpacity(0.1),
                                          width: 1.sp)),
                            suffixIcon: Icon(Icons.save,color: kBlackColor,size: 25.sp),
                            contentPadding: EdgeInsets.only(top: 10.sp,bottom: 5.sp,left: 10.sp,right: 10.sp),
                            hintText: "Time For Client",
                            hintStyle: CustomTextStyle.regularFont14Style
                        ),
                      ),
                    ),
                    SizedBox(height: 10.sp),
                  ],
                );

              }, separatorBuilder: (context, index) => Divider(),
                  itemCount: timeListData.userList?.length ?? 0
              ),

            ],
          ),
        );
      },),
    );
  }
}

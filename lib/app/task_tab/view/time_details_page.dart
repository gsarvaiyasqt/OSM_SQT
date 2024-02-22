

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/task_tab/domain/request/update_client_min_response_model.dart';
import 'package:osm_flutter/app/task_tab/domain/request/update_timer_request_model.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/utils/common_utils/skeleton_loading.dart';
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
    final timeDetailsLoader = taskProvider.getTaskDateWiseTimeResponse.state == Status.LOADING;
    final taskData = taskProvider.getTaskDetailsResponse.data?.data?.task;
    final timeList = taskProvider.timeList;

    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      body: ListView.builder(
        itemCount: timeDetailsLoader ?  10 :  timeList.length,
        itemBuilder: (context, index) {

          if(timeDetailsLoader){
            return timeDetailsSimmer();
          }

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
                        Text(timeListData.totalMns ?? "",style: CustomTextStyle.regularFont14Style),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text("Client Time : ",style: CustomTextStyle.boldFont14Style),
                        Text(timeListData.clintMin ?? "",style: CustomTextStyle.regularFont14Style),
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
                    userData?.textEditingController ??= TextEditingController();
                    userData?.oldStartTime ??= DateTime.now();
                    userData?.oldEndTime??= DateTime.now();
                    userData?.oldTimerDate??= DateTime.now();
                    if(userData?.totalTimeInMinutesForClient != null){
                      userData?.textEditingController?.text = userData.totalTimeInMinutesForClient.toString();
                    }

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
                        Text(formattedTime(timeInSecond: userData?.totalTimeInMinites ?? 0),style: CustomTextStyle.boldFont14Style),
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
                                  onTap: () async{
                                    if(userData?.startTime != null){

                                      final startTime = await showDatePicker(context: context, firstDate: DateTime(1800), lastDate: DateTime.now(),initialDate: userData?.startTime);

                                      setState(() {

                                        if(startTime != null){

                                          userData?.startTime = DateTime(startTime.year,startTime.month,startTime.day,userData.startTime?.hour ?? 0,userData.startTime?.minute ?? 0,userData.startTime?.second ?? 0,);

                                        }

                                      });

                                      print("is DateTime is ${userData?.oldStartTime}");


                                    }
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
                                  onTap: () async{
                                    if(userData?.endTime != null){

                                     final endTime = await showDatePicker(context: context, firstDate: DateTime(1800), lastDate: DateTime(3000),initialDate: userData?.endTime);

                                     setState(() {

                                       if(endTime != null){

                                         userData?.endTime = DateTime(endTime.year,endTime.month,endTime.day,userData.endTime?.hour ?? 0,userData.endTime?.minute ?? 0,userData.endTime?.second ?? 0,);

                                       }

                                     });
                                    }
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
                              GestureDetector(
                                onTap: () async{

                                  final startTime = userData?.startTime;

                                  if(startTime != null){

                                    final isStartTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: startTime.hour ?? 0, minute: startTime.minute ?? 0));

                                    if(isStartTime != null){

                                      userData?.startTime = DateTime(userData.startTime?.year ?? 0,userData.startTime?.month ?? 0,userData.startTime?.day ?? 0,isStartTime.hour,isStartTime.minute);

                                    }

                                  }
                                  setState(() {});
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: kBlackColor.withOpacity(0.1)
                                        )
                                    ),
                                    child: Text(userData?.startTime != null ? DateFormat.jms().format(userData!.startTime!) : "_",style: CustomTextStyle.regularFont12Style,)),
                              ),
                              SizedBox(height: 5.sp),
                              Text("Time",style: CustomTextStyle.boldFont14Style),
                              SizedBox(height: 5.sp),
                              GestureDetector(
                                onTap: () async{
                                  final endTime = userData?.endTime;

                                  if(endTime != null){

                                    final isEndTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: endTime.hour ?? 0, minute: endTime.minute ?? 0));


                                    if(isEndTime != null){

                                      setState(() {


                                        userData?.endTime = DateTime(userData.endTime?.year ?? 0,userData.endTime?.month ?? 0,userData.endTime?.day ?? 0,isEndTime.hour,isEndTime.minute);


                                      });


                                    }



                                  }
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: kBlackColor.withOpacity(0.1)
                                        )
                                    ),
                                    child: Text(userData?.endTime != null ? DateFormat.jms().format(userData!.endTime!) : "_",style: CustomTextStyle.regularFont12Style,)),
                              ),
                            ],
                          )),
                          GestureDetector(
                            onTap: () async{


                              try {

                                if(userData != null){


                                  final timerData = DateFormat("yyyy-MM-dd").format(userData.timerDate!);
                                  final oldTimerData = DateFormat("yyyy-MM-dd").format(userData.oldTimerDate!);

                                  var updateValue =  UpdateTimerRequestModel(
                                      taskId: taskData?.taskId,
                                      projectId: taskData?.projectId,
                                      userTaskTimerID: userData.userTaskTimerId,
                                      taskUserName: userData.displayName ?? "",
                                      endTime: userData.endTime,
                                      timerDate: timerData,
                                      startTime:userData.startTime,
                                      oldStartTime: userData.oldStartTime,
                                      oldTimerDate: oldTimerData,
                                      oldEndTime:userData.oldEndTime
                                  );

                                  try {

                                    final  taskProvider = context.read<TaskProvider>();

                                    await taskProvider.updateTimerData(updateTimerRequestModel: updateValue);

                                    taskProvider.timeList = [];

                                    await taskProvider.getTaskDateWiseTimeResponseModel(taskId: taskData?.taskId,projectId:taskData?.projectId);

                                  } catch (e) {

                                    Toaster.showMessage(context, msg: e.toString());

                                  }

                                }
                              } catch (e) {
                                Toaster.showMessage(context, msg: e.toString());
                              };
                            },
                            child: Container(
                               padding: EdgeInsets.all(2.sp),
                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.sp),color: kBlackColor),
                               child: Icon(Icons.save,size: 25.sp,color: kWhiteColor,)),
                          )
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
                            suffixIcon: GestureDetector(
                                onTap: () async{


                                  if(userData != null){

                                    final timerData = DateFormat("yyyy-MM-dd").format(userData.timerDate!);

                                    try {

                                      final taskProvider = context.read<TaskProvider>();

                                      print("userData.textEditingController?.text is ${userData.textEditingController?.text.isNotEmpty}");

                                      if(userData.textEditingController?.text.isNotEmpty == true){

                                        await taskProvider.updateClientTimer(updateClientMinsResponseModel: UpdateClientMinsResponseModel(
                                            projectId: userData.projectId,
                                            taskUserName: userData.displayName,
                                            userTaskTimerID: userData.userTaskTimerId,
                                            taskId: userData.taskId,
                                            taskDate: timerData,
                                            totalMins: int.tryParse(userData.textEditingController?.text ?? "0"),
                                            oldTotalTimeInMinutes: (userData.oldMints ?? 0)
                                        ));

                                        userData.textEditingController?.clear();

                                        taskProvider.timeList = [];

                                        await taskProvider.getTaskDateWiseTimeResponseModel(taskId: taskData?.taskId,projectId:taskData?.projectId);

                                      }

                                    } catch (e) {
                                      Toaster.showMessage(context, msg: e.toString());
                                    }

                                  }

                                },
                                child: Icon(Icons.save,color: kBlackColor,size: 25.sp)),
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

  Widget timeDetailsSimmer(){
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      margin: EdgeInsets.only(bottom: 5.sp),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              children: [
                SkeletonView(
                  isLoading: true,
                  borderRadius: BorderRadius.circular(100),
                    skeletonBody: SizedBox(
                      height: 40.sp,
                      width: 40.sp,
                    )
                ),

                SizedBox(width: 10.sp),
            
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonView(
                      isLoading: true,
                      borderRadius: BorderRadius.circular(8.sp),
                        skeletonBody: SizedBox(
                          height: 20.sp,
                          width: 180.sp,
                        )
                    ),

                    SizedBox(height: 5.sp),

                    SkeletonView(
                      isLoading: true,
                      borderRadius: BorderRadius.circular(8.sp),
                        skeletonBody: SizedBox(
                          height: 20.sp,
                          width: 120.sp,
                        )
                    ),
                  ],
                ),

              ],
            ),
          ),

          Padding(
            padding:  EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonView(
                    isLoading: true,
                    borderRadius: BorderRadius.circular(8.sp),
                    skeletonBody: SizedBox(
                      height: 40.sp,
                      width: 180.sp,
                    )
                ),
                SkeletonView(
                    isLoading: true,
                    borderRadius: BorderRadius.circular(8.sp),
                    skeletonBody: SizedBox(
                      height: 40.sp,
                      width: 180.sp,
                    )
                ),
              ],
            ),
          ),

          Divider(height: 1,color: Colors.black12,endIndent: 10,indent: 10,),

          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonView(
                        isLoading: true,
                        borderRadius: BorderRadius.circular(8.sp),
                        skeletonBody: SizedBox(
                          height: 30.sp,
                          width: 180.sp,
                        )
                    ),
            
                    SizedBox(height: 5.sp),
            
                    SkeletonView(
                        isLoading: true,
                        borderRadius: BorderRadius.circular(8.sp),
                        skeletonBody: SizedBox(
                          height: 20.sp,
                          width: 120.sp,
                        )
                    ),
                  ],
                ),
            
                SkeletonView(
                    isLoading: true,
                    borderRadius: BorderRadius.circular(8),
                    skeletonBody: SizedBox(
                      height: 40.sp,
                      width: 40.sp,
                    )
                ),
            
              ],
            ),
          ),
        ],
      ),
    );
  }
}

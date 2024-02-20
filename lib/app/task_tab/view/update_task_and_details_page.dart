import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/task_tab/view/comments_page.dart';
import 'package:osm_flutter/app/task_tab/view/file_page.dart';
import 'package:osm_flutter/app/task_tab/view/logs_page.dart';
import 'package:osm_flutter/app/task_tab/view/task_deatils.dart';
import 'package:osm_flutter/app/task_tab/view/task_detailes_page.dart';
import 'package:provider/provider.dart';

import '../../../base/base.dart';
import '../../../base/view/base_components/custom_button.dart';
import '../../../base/view/base_components/custom_text_form_filed.dart';
import '../../../base/view/base_components/loading_view.dart';
import '../../../base/view/base_components/multi_selection_images.dart';
import '../../../utils/common_utils/custom_details_textfield.dart';
import '../../../utils/common_utils/custom_drop_down_widget.dart';
import '../../../utils/common_utils/custom_serch_view_page.dart';
import '../../../utils/utils.dart';
import '../domain/request/create_task_req_model.dart';
import '../domain/request/save_user_in_deatils_req_model.dart';
import '../domain/respones/get_task_details_response_model.dart';
import '../route/task_route.dart';
import '../view_model/task_provider.dart';
class UpdateTaskAndDetails extends StatefulWidget {
  const UpdateTaskAndDetails({Key? key}) : super(key: key);

  @override
  State<UpdateTaskAndDetails> createState() => _UpdateTaskAndDetailsState();
}

class _UpdateTaskAndDetailsState extends State<UpdateTaskAndDetails> {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List<File>? mediaFileList = [];
  List<SaveUserDataInDetailsData> saveUserList = [];
  bool isEditable = false;

  int selectedIndex = 0;

  List<String> taskTabList = [
    "Task details","Comments","File","Logs"
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: kSecondaryBackgroundColor,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () async{
              final pop = Navigator.of(context);
              await context.read<TaskProvider>().resetTaskReqData();
              pop.pop();
            },
            child: const Icon(Icons.arrow_back,color: kBlackColor)),
        title: Text("Task Details Updates", style: CustomTextStyle.boldFont22Style),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    isEditable =! isEditable;
                  });
                },
                child: Icon(!isEditable ? Icons.edit : Icons.close)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          children: [
            Container(
              // width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kWhiteColor,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(taskTabList.length, (index) => GestureDetector(
                    onTap: () {
                      selectedIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 5.sp),
                      margin: EdgeInsets.all(2.sp),
                        decoration: BoxDecoration(
                          color: selectedIndex == index ? kLightWhiteColor : null,
                          borderRadius: BorderRadius.circular(5.sp)
                        ),
                        child: Text(taskTabList[index],style: CustomTextStyle.semiBoldFont16Style,)),
                  )),
                ),
              ),

            ),
            SizedBox(height: 20.sp),
            Expanded(child: IndexedStack(
              index: selectedIndex,
              children: [
                TaskDetailsPage(),
                CommentPage(),
                FilePage(),
                LogsPage()
              ],
            ))
          ],
        ),
      ),
      // body:createTaskDetailLoading ?
      // const Center(child: Loading(color: kSecondaryColor,)) :
      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.sp),
      //   child: SingleChildScrollView(
      //       child: WillPopScope(
      //           onWillPop: () async{
      //             Navigator.of(context).pop();
      //             return await context.read<TaskProvider>().resetTaskReqData();
      //           },
      //           child: Column(
      //             children: [
      //               CustomDropDownWidget(
      //                 selectedItem: createTaskReqModel.name,
      //                 name: "Project Name",
      //                 onTap: () {},
      //               ),
      //               SizedBox(height: 10.sp),
      //
      //               CustomTextField(
      //                 isEnable: (isEditable ? true : false),
      //                 name: "Title",
      //                 hint: "Title",
      //                 controller: titleController,
      //                 suffix: isEditable ? GestureDetector(
      //                     onTap: () async{
      //                       updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.Title;
      //                       updateTaskStatusPriorityUiState.fieldValue = createTaskReqModel.title;
      //                       await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
      //                     },
      //                     child: const Icon(Icons.save,color: kBlackColor)) : null,
      //                 onChanged: (value) {
      //                   setState(() {
      //                     createTaskReqModel.title = value;
      //                   });
      //                 },
      //               ),
      //
      //               SizedBox(height: 10.sp),
      //
      //               Row(
      //                 children: [
      //                   Expanded(
      //                     child: CustomDatePickerWidget(
      //                         firstDate: DateTime.now(),
      //                         // initialDate: createTaskReqModel.startDate,
      //                         lastDate: createTaskReqModel.endDate,
      //                         onSelectedDateTime: (p0) async{
      //                           setState(() {
      //                             createTaskReqModel.startDate = p0;
      //                           });
      //                           if(isEditable){
      //                             updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.StartDate;
      //                             updateTaskStatusPriorityUiState.fieldValue = DateFormat("yyyy-MM-dd").format(p0);
      //                             await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
      //                           }
      //                         },
      //                         shoDatePicker: (isEditable ? false : true),
      //                         radius: 5,
      //                         name: createTaskReqModel.startDate != null
      //                             ? DateFormat("MM/dd/yyyy").format(createTaskReqModel.startDate!)
      //                             : "Start Date"),
      //                   ),
      //                   SizedBox(width: 5.sp),
      //                   Expanded(
      //                     child: CustomDatePickerWidget(
      //                         initialDate: createTaskReqModel.startDate,
      //                         firstDate: createTaskReqModel.startDate ?? DateTime.now(),
      //                         onSelectedDateTime: (p0) async{
      //                           setState(() {
      //                             createTaskReqModel.endDate = p0;
      //                           });
      //
      //                           if(isEditable){
      //                             updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.EndDate;
      //                             updateTaskStatusPriorityUiState.fieldValue = DateFormat("yyyy-MM-dd").format(p0);
      //                             await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
      //                           }
      //                         },
      //                         shoDatePicker: (isEditable ? false : true),
      //                         radius: 5,
      //                         name: createTaskReqModel.endDate != null
      //                             ? DateFormat("MM/dd/yyyy").format(createTaskReqModel.endDate!)
      //                             : "End Date"),
      //                   ),
      //                 ],
      //               ),
      //
      //               SizedBox(height: 10.sp),
      //
      //               CustomDropDownWidget(
      //                 // isUpdated: taskUpdateModel?.isUpdate,
      //                 isEditable: isEditable,
      //                 multiSelection: createTaskReqModel.multipleTestAssignUser,
      //                 name: "Assign to",
      //                 onTap: () async{
      //                   // if(taskUpdateModel?.isUpdate == true){
      //                   //
      //                   //   if(isEditable){
      //                   //
      //                   //     Navigator.push(context, MaterialPageRoute(
      //                   //       builder: (context) {
      //                   //         return CustomSearchViewPage(
      //                   //           selectedItems: createTaskReqModel.multipleTestAssignUser,
      //                   //           onMultipleSelectedChange: (value) async{
      //                   //             final taskProvider = context.read<TaskProvider>();
      //                   //             createTaskReqModel.multipleTestAssignUser = [];
      //                   //             for (var element in value) {
      //                   //               var model = SaveUserDataInDetailsData(
      //                   //                   projectId: createTaskReqModel.projectID,
      //                   //                   userId: element.projectId,
      //                   //                   taskUserId: 0,
      //                   //                   name: element.name,
      //                   //                   taskId: createTaskReqModel.taskID
      //                   //               );
      //                   //               saveUserList.add(model);
      //                   //               createTaskReqModel.multipleTestAssignUser?.add(element);
      //                   //             }
      //                   //             await taskProvider.saveUserInDetails(saveDataInDetailReqMode: SaveDataInDetailReqMode(saveUserList: saveUserList));
      //                   //           },
      //                   //           projectId: createTaskReqModel.projectID,
      //                   //           createTaskEnum: CreateTaskEnum.ASSIGN,
      //                   //           name: "Assign To",
      //                   //         );
      //                   //       },
      //                   //     ));
      //                   //
      //                   //   }
      //                   //
      //                   // }else{
      //                   //
      //                   //   if(createTaskReqModel.name != null){
      //                   //     Navigator.push(context, MaterialPageRoute(
      //                   //       builder: (context) {
      //                   //         return CustomSearchViewPage(
      //                   //           selectedItems: createTaskReqModel.multipleTestAssignUser,
      //                   //           onMultipleSelectedChange: (value) {
      //                   //             createTaskReqModel.multipleTestAssignUser = [];
      //                   //             for (var element in value) {
      //                   //               createTaskReqModel.multipleTestAssignUser?.add(element);
      //                   //             }
      //                   //           },
      //                   //           projectId: createTaskReqModel.projectID,
      //                   //           createTaskEnum: CreateTaskEnum.ASSIGN,
      //                   //           name: "Assign To",
      //                   //         );
      //                   //       },
      //                   //     ));
      //                   //   }else{
      //                   //
      //                   //     Toaster.showMessage(context, msg: "Please select project then before assign users");
      //                   //
      //                   //   }
      //                   //
      //                   // }
      //                   if(isEditable){
      //
      //                     Navigator.push(context, MaterialPageRoute(
      //                       builder: (context) {
      //                         return CustomSearchViewPage(
      //                           selectedItems: createTaskReqModel.multipleTestAssignUser,
      //                           onMultipleSelectedChange: (value) async{
      //                             final taskProvider = context.read<TaskProvider>();
      //                             createTaskReqModel.multipleTestAssignUser = [];
      //                             for (var element in value) {
      //                               var model = SaveUserDataInDetailsData(
      //                                   projectId: createTaskReqModel.projectID,
      //                                   userId: element.projectId,
      //                                   taskUserId: 0,
      //                                   name: element.name,
      //                                   taskId: createTaskReqModel.taskID
      //                               );
      //                               saveUserList.add(model);
      //                               createTaskReqModel.multipleTestAssignUser?.add(element);
      //                             }
      //                             await taskProvider.saveUserInDetails(saveDataInDetailReqMode: SaveDataInDetailReqMode(saveUserList: saveUserList));
      //                           },
      //                           projectId: createTaskReqModel.projectID,
      //                           createTaskEnum: CreateTaskEnum.ASSIGN,
      //                           name: "Assign To",
      //                         );
      //                       },
      //                     ));
      //
      //                   }
      //
      //                 },
      //               ),
      //
      //               CustomDropDownWidget(
      //                 name: "Status",
      //                 selectedItem: createTaskReqModel.status,
      //                 onTap: () async{
      //                   setState(() {
      //
      //                     if(isEditable){
      //                       Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                         return CustomSearchViewPage(
      //                           createTaskEnum: CreateTaskEnum.STATUS,
      //                           name: "Status",
      //                           onChange: (value) async{
      //                             createTaskReqModel.status = value.name;
      //                             updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.Status;
      //                             updateTaskStatusPriorityUiState.fieldValue = createTaskReqModel.status;
      //                             await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
      //                           },
      //                         );
      //                       },));
      //                     }
      //                     // if(taskUpdateModel?.isUpdate == true){
      //                     //   if(isEditable){
      //                     //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                     //       return CustomSearchViewPage(
      //                     //         createTaskEnum: CreateTaskEnum.STATUS,
      //                     //         name: "Status",
      //                     //         onChange: (value) async{
      //                     //           createTaskReqModel.status = value.name;
      //                     //           updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.Status;
      //                     //           updateTaskStatusPriorityUiState.fieldValue = createTaskReqModel.status;
      //                     //           await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
      //                     //         },
      //                     //       );
      //                     //     },));
      //                     //   }
      //                     // }else{
      //                     //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                     //     return CustomSearchViewPage(
      //                     //       createTaskEnum: CreateTaskEnum.STATUS,
      //                     //       name: "Status",
      //                     //       onChange: (value) {
      //                     //         setState(() {
      //                     //           createTaskReqModel.status = value.name;
      //                     //         });
      //                     //       },
      //                     //     );
      //                     //   },));
      //                     // }
      //
      //
      //
      //
      //                   });
      //                 },
      //               ),
      //
      //               CustomDropDownWidget(
      //                 selectedItem: createTaskReqModel.priority,
      //                 name: "Priority",
      //                 onTap: () {
      //
      //                   if(isEditable){
      //                     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                       return CustomSearchViewPage(
      //                         createTaskEnum: CreateTaskEnum.PRIORITY,
      //                         name: "Priority",
      //                         onChange: (value) async{
      //                           createTaskReqModel.priority = value.name;
      //                           updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.Priority;
      //                           updateTaskStatusPriorityUiState.fieldValue = createTaskReqModel.priority;
      //                           await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
      //                           // setState(() {});
      //                         },
      //                       );
      //                     },));
      //                   }
      //                   // if(taskUpdateModel?.isUpdate == true){
      //                   //   if(isEditable){
      //                   //     Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                   //       return CustomSearchViewPage(
      //                   //         createTaskEnum: CreateTaskEnum.PRIORITY,
      //                   //         name: "Priority",
      //                   //         onChange: (value) async{
      //                   //           createTaskReqModel.priority = value.name;
      //                   //           updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.Priority;
      //                   //           updateTaskStatusPriorityUiState.fieldValue = createTaskReqModel.priority;
      //                   //           await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
      //                   //           // setState(() {});
      //                   //         },
      //                   //       );
      //                   //     },));
      //                   //   }
      //                   // }else{
      //                   //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //                   //     return CustomSearchViewPage(
      //                   //       createTaskEnum: CreateTaskEnum.PRIORITY,
      //                   //       name: "Priority",
      //                   //       onChange: (value) {
      //                   //         setState(() {
      //                   //           createTaskReqModel.priority = value.name;
      //                   //         });
      //                   //       },
      //                   //     );
      //                   //   },));
      //                   // }
      //
      //
      //                 },
      //               ),
      //
      //               SizedBox(height: 10.sp,),
      //               if(descriptionController.text.isNotEmpty)
      //               CustomDescriptionField(
      //                 isEnable: false,
      //                 // isEnable: taskUpdateModel?.isUpdate == true ? false : true,
      //                 controller: descriptionController,
      //                 hint: "Details",
      //                 maxLine: 5,
      //                 onChanged: (value) {
      //                   setState(() {
      //                     createTaskReqModel.details = value;
      //                   });
      //                 },
      //               ),
      //               SizedBox(height: 10.sp),
      //               ListView.builder(
      //                 shrinkWrap: true,
      //                 itemCount: createTaskReqModel.userTaskSubPointList?.length ?? 0,
      //                 physics: const NeverScrollableScrollPhysics(),
      //                 itemBuilder: (context, index) {
      //                   final subPoint = createTaskReqModel.userTaskSubPointList?[index];
      //                   final isDone = subPoint?.isDone == 1;
      //                   return GestureDetector(
      //                     onTap: isEditable ?  () async{
      //                       await context.read<TaskProvider>().getCheckAndUnCheckSubPointData(taskSubPointID: subPoint?.taskSubPointId,isDone: !isDone);
      //                     } : null,
      //                     child: Row(
      //                       children: [
      //                         AnimatedContainer(
      //                           margin: EdgeInsets.all(5.sp),
      //                           padding: EdgeInsets.all(5.sp),
      //                           duration: const Duration(milliseconds: 100),
      //                           decoration: BoxDecoration(
      //                             border: !isDone ?  Border.all(
      //                                 color: kBlackColor
      //                             ) : null,
      //                             color: isDone ? kSecondaryColor : null,
      //                             borderRadius: BorderRadius.circular(5),
      //                           ),
      //                           child: isDone ? SizedBox(width: 20.sp,height: 20.sp,child: Icon(Icons.done,color: kWhiteColor,size: 20.sp),) : SizedBox(width: 18.sp,height: 18.sp),
      //
      //                         ),
      //                         SizedBox(width: 5.sp),
      //                         Text(subPoint?.title ?? "",style: CustomTextStyle.semiBoldFont18Style),
      //                       ],
      //                     ),
      //                   );
      //                 },
      //                 // itemBuilder: (context, index) {
      //                 //   if(taskUpdateModel?.isUpdate != true){
      //                 //     return Stack(
      //                 //       children: [
      //                 //
      //                 //         Padding(
      //                 //           padding:  EdgeInsets.all(10.sp),
      //                 //           child: CustomTextField(
      //                 //             hint: "Add SubPoint",
      //                 //             onChanged: (value) {
      //                 //               setState(() {
      //                 //
      //                 //                 createTaskReqModel.userTaskSubPointList?[index].title = value;
      //                 //
      //                 //               });
      //                 //             },
      //                 //           ),
      //                 //         ),
      //                 //         Positioned(
      //                 //             right: 0,
      //                 //             child: GestureDetector(
      //                 //               onTap: () {
      //                 //                 setState(() {
      //                 //                   createTaskReqModel.userTaskSubPointList?.remove(createTaskReqModel.userTaskSubPointList?[index]);
      //                 //                 });
      //                 //               },
      //                 //               child: Container(
      //                 //                   decoration: BoxDecoration(
      //                 //                       border: Border.all(
      //                 //                         color: kBlackColor,
      //                 //                       ),
      //                 //                       borderRadius: BorderRadius.circular(100)
      //                 //                   ),
      //                 //                   child: Padding(
      //                 //                     padding: const EdgeInsets.all(1.0),
      //                 //                     child: Icon(Icons.delete,color: kBlackColor,size: 25.sp),
      //                 //                   )),
      //                 //             )),
      //                 //       ],
      //                 //     );
      //                 //   }else{
      //                 //     final subPoint = createTaskReqModel.userTaskSubPointList?[index];
      //                 //     final isDone = subPoint?.isDone == 1;
      //                 //     return GestureDetector(
      //                 //       onTap: isEditable ?  () async{
      //                 //         await context.read<TaskProvider>().getCheckAndUnCheckSubPointData(taskSubPointID: subPoint?.taskSubPointId,isDone: !isDone);
      //                 //       } : null,
      //                 //       child: Row(
      //                 //         children: [
      //                 //           AnimatedContainer(
      //                 //             margin: EdgeInsets.all(5.sp),
      //                 //             padding: EdgeInsets.all(5.sp),
      //                 //             duration: const Duration(milliseconds: 100),
      //                 //             decoration: BoxDecoration(
      //                 //               border: !isDone ?  Border.all(
      //                 //                   color: kBlackColor
      //                 //               ) : null,
      //                 //               color: isDone ? kSecondaryColor : null,
      //                 //               borderRadius: BorderRadius.circular(5),
      //                 //             ),
      //                 //             child: isDone ? SizedBox(width: 20.sp,height: 20.sp,child: Icon(Icons.done,color: kWhiteColor,size: 20.sp),) : SizedBox(width: 18.sp,height: 18.sp),
      //                 //
      //                 //           ),
      //                 //           SizedBox(width: 5.sp),
      //                 //           Text(subPoint?.title ?? "",style: CustomTextStyle.semiBoldFont18Style),
      //                 //         ],
      //                 //       ),
      //                 //     );
      //                 //   }
      //                 //
      //                 // },
      //               ),
      //               SizedBox(height: 20.sp),
      //
      //             ],
      //           )
      //       )
      //   ),
      // ),

    );
  }
}

// import 'dart:io';
//
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:osm_flutter/base/base.dart';
// import 'package:osm_flutter/utils/utils.dart';
// import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
// import '../../../base/view/base_components/multi_selection_images.dart';
// import 'package:osm_flutter/base/view/base_components/custom_button.dart';
// import 'package:osm_flutter/utils/common_utils/custom_details_textfield.dart';
// import 'package:osm_flutter/utils/common_utils/custom_drop_down_widget.dart';
// import 'package:osm_flutter/utils/common_utils/custom_serch_view_page.dart';
// import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
// import 'package:osm_flutter/app/task_tab/domain/request/get_user_and_project_request_model.dart';
//
// import '../domain/request/create_task_req_model.dart';
//
// class CreateTaskPage extends StatefulWidget {
//   const CreateTaskPage({Key? key}) : super(key: key);
//
//   @override
//   State<CreateTaskPage> createState() => _CreateTaskPageState();
// }
//
// class _CreateTaskPageState extends State<CreateTaskPage> {
//
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController titleController = TextEditingController();
//   List<File>? mediaFileList = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
//       final taskProvider = context.read<TaskProvider>();
//      await taskProvider.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: GetProjectAndAssignUserRequestModel());
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//    final taskProvider = context.watch<TaskProvider>();
//    final createTaskLoading = taskProvider.getGetCreateTaskResponse.state == Status.LOADING;
//    final getStatusLoading = taskProvider.getGerStatusAndPriorityResponse.state == Status.LOADING;
//    final getProjectLoading = taskProvider.getProjectAndUserResponse.state == Status.LOADING;
//    final createTaskReqModel = taskProvider.createTaskReqModel;
//    return Scaffold(
//       backgroundColor: kSecondaryBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: kSecondaryBackgroundColor,
//         title: Text("Create Task", style: CustomTextStyle.boldFont22Style),
//       ),
//       // bottomNavigationBar: SizedBox(),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.sp),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               CustomDropDownWidget(
//                 selectedItem: createTaskReqModel.name,
//                 name: "Project Name",
//                 onTap: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return CustomSearchViewPage(
//                           isLoading: getProjectLoading,
//                           onMultipleSelectedChange: (value) {
//                             setState(() {
//
//                             });
//                           },
//                           createTaskEnum: CreateTaskEnum.PROJECT,
//                           name: "Project Name",
//                           onChange: (value) async{
//                             setState(() {
//                               createTaskReqModel.name = value.name;
//                               createTaskReqModel.projectID = value.projectId;
//                               if(value.name != null){
//                                 createTaskReqModel.assignInName = null;
//                               }
//                             });
//                             },
//                         );
//                       },
//                     ));
//
//                 },
//               ),
//               SizedBox(height: 10.sp),
//
//               CustomTextField(
//                 name: "Title",
//                 hint: "Title",
//                 controller: titleController,
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
//                         onSelectedDateTime: (p0) {
//                           setState(() {
//                             createTaskReqModel.startDate = p0;
//                           });
//                         },
//                         shoDatePicker: false,
//                         radius: 5,
//                         name: createTaskReqModel.startDate != null
//                             ? DateFormat("MM/dd/yyyy").format(createTaskReqModel.startDate!)
//                             : "Start Date"),
//                   ),
//                   SizedBox(width: 5.sp),
//                   Expanded(
//                     child: CustomDatePickerWidget(
//                         onSelectedDateTime: (p0) {
//                           setState(() {
//                             createTaskReqModel.endDate = p0;
//                           });
//                         },
//                         shoDatePicker: false,
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
//                 multiSelection: createTaskReqModel.multipleAssignUser,
//                 name: "Assign to",
//                 onTap: () async{
//                   if(createTaskReqModel.name != null){
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return CustomSearchViewPage(
//                           isLoading: getProjectLoading,
//                           onMultipleSelectedChange: (value) {
//                             for(var i = 0; i < value.length;i++){
//                               createTaskReqModel.multipleTestAssignUser?.removeWhere((element) => element.projectId == value[i].projectId);
//                               createTaskReqModel.multipleAssignUser.add(value[i].name ?? "");
//                               createTaskReqModel.userList?.add(UserListReqModel(userId: value[i].projectId.toString()));
//                             }
//                             setState(() {});
//                             },
//                           projectId: createTaskReqModel.projectID,
//                           createTaskEnum: CreateTaskEnum.ASSIGN,
//                           name: "Assign To",
//                           onChange: (value) {
//                             // setState(() {
//                             //   createTasRequestModel.assignInName = value.name;
//                             // });
//                           },
//                         );
//                       },
//                     ));
//                   }
//                 },
//               ),
//
//               CustomDropDownWidget(
//                 name: "Status",
//                 selectedItem: createTaskReqModel.status,
//                 onTap: () async{
//                   setState(() {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) {
//                       return CustomSearchViewPage(
//                         isLoading: getStatusLoading,
//                         createTaskEnum: CreateTaskEnum.STATUS,
//                         name: "Status",
//                         onChange: (value) {
//                           setState(() {
//                             createTaskReqModel.status = value.name;
//                           });
//                         },
//                       );
//                     },));
//                   });
//                 },
//               ),
//
//               CustomDropDownWidget(
//                 selectedItem: createTaskReqModel.priority,
//                 name: "Priority",
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return CustomSearchViewPage(
//                       isLoading: getStatusLoading,
//                       createTaskEnum: CreateTaskEnum.PRIORITY,
//                       name: "Priority",
//                       onChange: (value) {
//                         setState(() {
//                           createTaskReqModel.priority = value.name;
//                         });
//                       },
//                     );
//                   },));
//                 },
//               ),
//
//               SizedBox(height: 10.sp,),
//
//               CustomDescriptionField(
//                   controller: descriptionController,
//                   hint: "Details",
//                   maxLine: 5,
//                 onChanged: (value) {
//                   setState(() {
//                     createTaskReqModel.details = value;
//                   });
//                 },
//               ),
//
//
//
//               SizedBox(height: 20.sp),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomButton(
//                       btnText: "Add SubPoint",
//                       btnColor: kSecondaryColor,
//                       onTap: () {
//                         setState(() {
//                           createTaskReqModel.userTaskSubPointList?.add(UserTaskSubPointReqModel());
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(child: SizedBox.shrink())
//                 ],
//               ),
//
//               SizedBox(height: 20.sp),
//
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: createTaskReqModel.userTaskSubPointList?.length,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Stack(
//                   children: [
//
//                     Padding(
//                       padding:  EdgeInsets.all(10.sp),
//                       child: CustomTextField(
//                         hint: "Add SubPoint",
//                         onChanged: (value) {
//                           setState(() {
//
//                             createTaskReqModel.userTaskSubPointList?[index].title = value;
//
//                           });
//                         },
//                       ),
//                     ),
//                     Positioned(
//                         right: 0,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//
//
//                               print("createTaskReqModel.userTaskSubPointList is Test");
//
//                               createTaskReqModel.userTaskSubPointList?.remove(createTaskReqModel.userTaskSubPointList?[index]);
//                             });
//                           },
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: kBlackColor,
//                                   ),
//                                   borderRadius: BorderRadius.circular(100)
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(1.0),
//                                 child: Icon(Icons.delete,color: kBlackColor,size: 25.sp),
//                               )),
//                         )),
//                   ],
//                 );
//               },),
//
//               SizedBox(height: 20.sp),
//               MultiSelectionImage(
//                 // apiImgList: imageList,
//                 imageFileList: mediaFileList,
//                 imageFileDataTap: (val){
//
//
//
//
//                    setState(() {
//
//                      createTaskReqModel.docList = val;
//
//                    });
//                 },
//                 deleteImageOnTap: (val)async{
//                 },
//                 headerText: "Attachment",
//               ),
//               SizedBox(height: 20.sp),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomButton(
//                       btnText: "Create",
//                       btnColor: kSecondaryColor,
//                       isLoading: createTaskLoading,
//                       onTap: () async{
//                         try {
//                           await context.read<TaskProvider>().getCreateTaskData();
//                           Navigator.of(context).pop();
//                         } catch (e) {
//                           Toaster.showMessage(context, msg: e.toString());
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 10.sp),
//                   Expanded(
//                     child: CustomButton(
//                       btnText: "Cancel",
//                       textStyle: CustomTextStyle.boldFont16Style,
//                       btnColor: kWhiteColor,
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30.sp,)
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:osm_flutter/app/task_tab/domain/request/search_model.dart';
import 'package:osm_flutter/app/task_tab/domain/respones/get_task_details_response_model.dart';
import 'package:osm_flutter/base/view/base_components/custom_checkbox.dart';
import 'package:osm_flutter/base/view/base_components/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import '../../../base/view/base_components/multi_selection_images.dart';
import 'package:osm_flutter/base/view/base_components/custom_button.dart';
import 'package:osm_flutter/utils/common_utils/custom_details_textfield.dart';
import 'package:osm_flutter/utils/common_utils/custom_drop_down_widget.dart';
import 'package:osm_flutter/utils/common_utils/custom_serch_view_page.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/app/task_tab/domain/request/get_user_and_project_request_model.dart';

import '../domain/request/create_task_req_model.dart';
import '../route/task_route.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {

  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List<File>? mediaFileList = [];

  bool isEditable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final taskUpdateModel = ModalRoute.of(context)?.settings.arguments as TaskUpdateModel?;
      final taskProvider = context.read<TaskProvider>();
      // final taskWProvider = context.watch<TaskProvider>();



      if(taskUpdateModel?.isUpdate == true){


        if(taskUpdateModel?.id != null){

          await taskProvider.getTaskDetailsData(id: taskUpdateModel?.id);

          final task = taskProvider.getTaskDetailsResponse.data?.data;

          taskProvider.createTaskReqModel = CreateTaskReqModel.fromTaskDetailsData(task);

          titleController.text = task?.task?.title ?? "";
          descriptionController.text = task?.task?.details ?? "";
        }
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    final taskUpdateModel = ModalRoute.of(context)?.settings.arguments as TaskUpdateModel?;
    final taskProvider = context.watch<TaskProvider>();
    final createTaskLoading = taskProvider.getGetCreateTaskResponse.state == Status.LOADING;
    final createTaskDetailLoading = taskProvider.getTaskDetailsResponse.state == Status.LOADING;
    final createTaskReqModel = taskProvider.createTaskReqModel;
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
        title: Text("Create Task", style: CustomTextStyle.boldFont22Style),
        actions: [

          if(taskUpdateModel?.isUpdate == true)
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
      body:createTaskDetailLoading ?
      const Center(child: Loading(color: kSecondaryColor,)) :
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: WillPopScope(
            onWillPop: () async{
              Navigator.of(context).pop();
              return await context.read<TaskProvider>().resetTaskReqData();
              },
            child: Column(
              children: [
                CustomDropDownWidget(
                  selectedItem: createTaskReqModel.name,
                  name: "Project Name",
                  onTap: () {

                    if(taskUpdateModel?.isUpdate != true){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CustomSearchViewPage(
                            onMultipleSelectedChange: (value) {
                              setState(() {

                              });
                            },
                            createTaskEnum: CreateTaskEnum.PROJECT,
                            name: "Project Name",
                            onChange: (value) async{
                              setState(() {
                                if(value.name != null){
                                  createTaskReqModel.name = value.name;
                                  createTaskReqModel.projectID = value.projectId;
                                  createTaskReqModel.multipleTestAssignUser = [];
                                }
                              });
                            },
                          );
                        },
                      ));
                    }

                  },
                ),
                SizedBox(height: 10.sp),

                CustomTextField(
                  isEnable: (taskUpdateModel?.isUpdate == true) ? (isEditable ? true : false) : false,
                  name: "Title",
                  hint: "Title",
                  controller: titleController,
                  suffix: isEditable ? const Icon(Icons.save,color: kBlackColor,) : null,
                  onChanged: (value) {
                    setState(() {
                      createTaskReqModel.title = value;
                    });
                  },
                ),

                SizedBox(height: 10.sp),

                Row(
                  children: [
                    Expanded(
                      child: CustomDatePickerWidget(
                          firstDate: DateTime.now(),
                        // initialDate: createTaskReqModel.startDate,
                          lastDate: createTaskReqModel.endDate,
                          onSelectedDateTime: (p0) {
                            setState(() {
                              createTaskReqModel.startDate = p0;
                            });
                          },
                          shoDatePicker: taskUpdateModel?.isUpdate == true ? (isEditable ? false : true) : false,
                          radius: 5,
                          name: createTaskReqModel.startDate != null
                              ? DateFormat("MM/dd/yyyy").format(createTaskReqModel.startDate!)
                              : "Start Date"),
                    ),
                    SizedBox(width: 5.sp),
                    Expanded(
                      child: CustomDatePickerWidget(
                          initialDate: createTaskReqModel.startDate,
                          firstDate: createTaskReqModel.startDate ?? DateTime.now(),
                          onSelectedDateTime: (p0) {
                            setState(() {
                              createTaskReqModel.endDate = p0;
                            });
                          },
                          shoDatePicker: taskUpdateModel?.isUpdate == true ? (isEditable ? false : true) : false,
                          radius: 5,
                          name: createTaskReqModel.endDate != null
                              ? DateFormat("MM/dd/yyyy").format(createTaskReqModel.endDate!)
                              : "End Date"),
                    ),
                  ],
                ),

                SizedBox(height: 10.sp),

                CustomDropDownWidget(
                  isUpdated: taskUpdateModel?.isUpdate,
                  isEditable: isEditable,
                  multiSelection: createTaskReqModel.multipleTestAssignUser,
                  name: "Assign to",
                  onTap: () async{
                    if(taskUpdateModel?.isUpdate == true){

                      if(isEditable){

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CustomSearchViewPage(
                              selectedItems: createTaskReqModel.multipleTestAssignUser,
                              onMultipleSelectedChange: (value) {
                                createTaskReqModel.multipleTestAssignUser = [];
                                for (var element in value) {
                                  createTaskReqModel.multipleTestAssignUser?.add(element);
                                }
                              },
                              projectId: createTaskReqModel.projectID,
                              createTaskEnum: CreateTaskEnum.ASSIGN,
                              name: "Assign To",
                            );
                          },
                        ));

                      }

                    }else{

                      if(createTaskReqModel.name != null){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CustomSearchViewPage(
                              selectedItems: createTaskReqModel.multipleTestAssignUser,
                              onMultipleSelectedChange: (value) {
                                createTaskReqModel.multipleTestAssignUser = [];
                                for (var element in value) {
                                  createTaskReqModel.multipleTestAssignUser?.add(element);
                                }
                              },
                              projectId: createTaskReqModel.projectID,
                              createTaskEnum: CreateTaskEnum.ASSIGN,
                              name: "Assign To",
                            );
                          },
                        ));
                      }else{

                        Toaster.showMessage(context, msg: "Please select project then before assign users");

                      }

                    }


                  },
                ),

                CustomDropDownWidget(
                  name: "Status",
                  selectedItem: createTaskReqModel.status,
                  onTap: () async{
                    setState(() {
                      if(taskUpdateModel?.isUpdate == true){
                        if(isEditable){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return CustomSearchViewPage(
                              createTaskEnum: CreateTaskEnum.STATUS,
                              name: "Status",
                              onChange: (value) {
                                setState(() {
                                  createTaskReqModel.status = value.name;
                                });
                              },
                            );
                          },));
                        }
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CustomSearchViewPage(
                            createTaskEnum: CreateTaskEnum.STATUS,
                            name: "Status",
                            onChange: (value) {
                              setState(() {
                                createTaskReqModel.status = value.name;
                              });
                            },
                          );
                        },));
                      }




                    });
                  },
                ),

                CustomDropDownWidget(
                  selectedItem: createTaskReqModel.priority,
                  name: "Priority",
                  onTap: () {
                    if(taskUpdateModel?.isUpdate == true){
                      if(isEditable){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CustomSearchViewPage(
                            createTaskEnum: CreateTaskEnum.PRIORITY,
                            name: "Priority",
                            onChange: (value) {
                              setState(() {
                                createTaskReqModel.priority = value.name;
                              });
                            },
                          );
                        },));
                      }
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CustomSearchViewPage(
                          createTaskEnum: CreateTaskEnum.PRIORITY,
                          name: "Priority",
                          onChange: (value) {
                            setState(() {
                              createTaskReqModel.priority = value.name;
                            });
                          },
                        );
                      },));
                    }


                  },
                ),

                SizedBox(height: 10.sp,),

                CustomDescriptionField(
                  isEnable: taskUpdateModel?.isUpdate == true ? false : true,
                  controller: descriptionController,
                  hint: "Details",
                  maxLine: 5,
                  onChanged: (value) {
                    setState(() {
                      createTaskReqModel.details = value;
                    });
                  },
                ),


                if(taskUpdateModel?.isUpdate != true)
                SizedBox(height: 20.sp),
                if(taskUpdateModel?.isUpdate != true)
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        btnText: "Add SubPoint",
                        btnColor: kSecondaryColor,
                        onTap: () {
                          setState(() {
                            createTaskReqModel.userTaskSubPointList?.add(TaskSubpoint());
                          });
                        },
                      ),
                    ),
                    Expanded(child: SizedBox.shrink())
                  ],
                ),
                if(taskUpdateModel?.isUpdate != true)
                SizedBox(height: 20.sp),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: createTaskReqModel.userTaskSubPointList?.length ?? 0,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if(taskUpdateModel?.isUpdate != true){
                      return Stack(
                        children: [

                          Padding(
                            padding:  EdgeInsets.all(10.sp),
                            child: CustomTextField(
                              hint: "Add SubPoint",
                              onChanged: (value) {
                                setState(() {

                                  createTaskReqModel.userTaskSubPointList?[index].title = value;

                                });
                              },
                            ),
                          ),
                          Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    createTaskReqModel.userTaskSubPointList?.remove(createTaskReqModel.userTaskSubPointList?[index]);
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: kBlackColor,
                                        ),
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Icon(Icons.delete,color: kBlackColor,size: 25.sp),
                                    )),
                              )),
                        ],
                      );
                    }else{
                      final subPoint = createTaskReqModel.userTaskSubPointList?[index];
                      final isDone = subPoint?.isDone == 1;
                      return GestureDetector(
                        onTap: isEditable ?  () async{
                          await context.read<TaskProvider>().getCheckAndUnCheckSubPointData(taskSubPointID: subPoint?.taskSubPointId,isDone: !isDone);
                        } : null,
                        child: Row(
                          children: [
                            AnimatedContainer(
                              margin: EdgeInsets.all(5.sp),
                              padding: EdgeInsets.all(5.sp),
                              duration: const Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                border: !isDone ?  Border.all(
                                  color: kBlackColor
                                ) : null,
                                color: isDone ? kSecondaryColor : null,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: isDone ? SizedBox(width: 20.sp,height: 20.sp,child: Icon(Icons.done,color: kWhiteColor,size: 20.sp),) : SizedBox(width: 18.sp,height: 18.sp),

                            ),
                            SizedBox(width: 5.sp),
                            Text(subPoint?.title ?? "",style: CustomTextStyle.semiBoldFont18Style),
                          ],
                        ),
                      );
                    }

                  },),
                if(taskUpdateModel?.isUpdate != true)
                SizedBox(height: 20.sp),
                if(taskUpdateModel?.isUpdate != true)
                MultiSelectionImage(
                  // apiImgList: imageList,
                  imageFileList: mediaFileList,
                  imageFileDataTap: (val){




                    setState(() {

                      createTaskReqModel.docList = val;

                    });
                  },
                  deleteImageOnTap: (val)async{
                  },
                  headerText: "Attachment",
                ),
                if(taskUpdateModel?.isUpdate != true)
                SizedBox(height: 20.sp),
                if(taskUpdateModel?.isUpdate != true)
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        btnText: "Create",
                        btnColor: kSecondaryColor,
                        isLoading: createTaskLoading,
                        onTap: () async{
                          try {
                            await context.read<TaskProvider>().getCreateTaskData();
                            Navigator.of(context).pop();
                          } catch (e) {
                            Toaster.showMessage(context, msg: e.toString());
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Expanded(
                      child: CustomButton(
                        btnText: "Cancel",
                        textStyle: CustomTextStyle.boldFont16Style,
                        btnColor: kWhiteColor,
                        onTap: () async{
                          final taskProvider = context.read<TaskProvider>();
                          await taskProvider.resetTaskReqData();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.sp,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}

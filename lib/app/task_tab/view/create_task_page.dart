import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/tab/view_model/tab_bar_provider.dart';
import 'package:osm_flutter/app/task_tab/domain/request/get_user_and_project_request_model.dart';
import 'package:osm_flutter/app/task_tab/domain/request/search_model.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/base/base.dart';
import 'package:osm_flutter/base/view/base_components/custom_button.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/utils/common_utils/custom_details_textfield.dart';
import 'package:osm_flutter/utils/common_utils/custom_drop_down_widget.dart';
import 'package:osm_flutter/utils/common_utils/custom_serch_view_page.dart';
import 'package:osm_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../base/view/base_components/multi_selection_images.dart';
import '../domain/request/create_sub_point_model.dart';
import '../domain/request/create_task_req_model.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {

  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List<File>? mediaFileList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async{
      final taskProvider = context.read<TaskProvider>();
     await taskProvider.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: GetProjectAndAssignUserRequestModel());
    });
  }

  @override
  Widget build(BuildContext context) {
   final taskProvider = context.watch<TaskProvider>();
   final createTaskLoading = taskProvider.getGetCreateTaskResponse.state == Status.LOADING;
   final createTaskReqModel = taskProvider.createTaskReqModel;
   return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: kSecondaryBackgroundColor,
        title: Text("Create Task", style: CustomTextStyle.boldFont22Style),
      ),
      // bottomNavigationBar: SizedBox(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomDropDownWidget(
                selectedItem: createTaskReqModel.name,
                name: "Project Name",
                onTap: () {
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
                              createTaskReqModel.name = value.name;
                              createTaskReqModel.projectID = value.projectId;
                              if(value.name != null){

                                createTasRequestModel.assignInName = null;
                              }
                            });
                            },
                        );
                      },
                    ));

                },
              ),
              SizedBox(height: 10.sp),

              CustomTextField(
                name: "Title",
                hint: "Title",
                controller: titleController,
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
                        onSelectedDateTime: (p0) {
                          setState(() {
                            createTaskReqModel.startDate = p0;
                          });
                        },
                        shoDatePicker: false,
                        radius: 5,
                        name: createTaskReqModel.startDate != null
                            ? DateFormat("MM/dd/yyyy").format(createTaskReqModel.startDate!)
                            : "Start Date"),
                  ),
                  SizedBox(width: 5.sp),
                  Expanded(
                    child: CustomDatePickerWidget(
                        onSelectedDateTime: (p0) {
                          setState(() {
                            createTaskReqModel.endDate = p0;
                          });
                        },
                        shoDatePicker: false,
                        radius: 5,
                        name: createTaskReqModel.endDate != null
                            ? DateFormat("MM/dd/yyyy").format(createTaskReqModel.endDate!)
                            : "End Date"),
                  ),
                ],
              ),
          
              SizedBox(height: 10.sp),
          
              CustomDropDownWidget(
                multiSelection: createTaskReqModel.multipleAssignUser,
                name: "Assign to",
                onTap: () async{
                  if(createTaskReqModel.name != null){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return CustomSearchViewPage(
                          onMultipleSelectedChange: (value) {
                            for(var i = 0; i < value.length;i++){
                              createTaskReqModel.multipleAssignUser.add(value[i].name ?? "");
                              createTaskReqModel.userList?.add(UserListReqModel(userId: value[i].projectId.toString()));
                            }
                            setState(() {});
                            },
                          projectId: createTaskReqModel.projectID,
                          createTaskEnum: CreateTaskEnum.ASSIGN,
                          name: "Assign To",
                          onChange: (value) {
                            // setState(() {
                            //   createTasRequestModel.assignInName = value.name;
                            // });
                          },
                        );
                      },
                    ));
                  }
                },
              ),
          
              CustomDropDownWidget(
                name: "Status",
                selectedItem: createTaskReqModel.status,
                onTap: () async{
                  setState(() {
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
                  });
                },
              ),
          
              CustomDropDownWidget(
                selectedItem: createTaskReqModel.priority,
                name: "Priority",
                onTap: () {
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
                },
              ),

              SizedBox(height: 10.sp,),
              
              CustomDescriptionField(
                  controller: descriptionController,
                  hint: "Details",
                  maxLine: 5,
                onChanged: (value) {
                  setState(() {
                    createTaskReqModel.details = value;
                  });
                },
              ),



              SizedBox(height: 20.sp),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: "Add SubPoint",
                      btnColor: kSecondaryColor,
                      onTap: () {
                        setState(() {
                          createTaskReqModel.userTaskSubPointList?.add(UserTaskSubPointReqModel());
                        });
                      },
                    ),
                  ),
                  Expanded(child: SizedBox.shrink())
                ],
              ),

              SizedBox(height: 20.sp),

              ListView.builder(
                shrinkWrap: true,
                itemCount: createTaskReqModel.userTaskSubPointList?.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
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


                              print("createTaskReqModel.userTaskSubPointList is Test");

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
              },),

              SizedBox(height: 20.sp),
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
              SizedBox(height: 20.sp),
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
                      onTap: () {
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
    );
  }
}

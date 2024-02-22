import 'dart:io';
import 'package:intl/intl.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/task_provider.dart';
import '../domain/request/create_task_req_model.dart';
import '../domain/request/save_user_in_deatils_req_model.dart';
import '../../../utils/common_utils/custom_serch_view_page.dart';
import '../../../utils/common_utils/custom_drop_down_widget.dart';
import '../../../utils/common_utils/custom_details_textfield.dart';
import 'package:osm_flutter/base/view/base_components/loading_view.dart';
import '../../../base/view/base_components/custom_text_form_filed.dart';
class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({Key? key}) : super(key: key);

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {

  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List<File>? mediaFileList = [];
  List<SaveUserDataInDetailsData> saveUserList = [];
  bool isEditable = false;

  int selectedIndex = 0;

  List<String> taskTabList = [
    "Task details","Comments","File","Logs","Time Details"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final taskId = ModalRoute.of(context)?.settings.arguments as int;
      final taskProvider = context.read<TaskProvider>();

      await taskProvider.getTaskDetailsData(id: taskId);

      final task = taskProvider.getTaskDetailsResponse.data?.data;

      setState(() {

        taskProvider.createTaskReqModel = CreateTaskReqModel.fromTaskDetailsData(task);

        titleController.text = task?.task?.title ?? "";
        descriptionController.text = task?.task?.details ?? "";

      });
    });
  }




  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final getDetailsLoading = taskProvider.getTaskDetailsResponse.state == Status.LOADING;
    final createTaskReqModel = taskProvider.createTaskReqModel;
    final updateTaskStatusPriorityUiState = taskProvider.updateTaskStatusPriorityUiState;
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      body: getDetailsLoading ?
      const Center(child: Loading(
        color: kSecondaryColor,
      ),): Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
            child: WillPopScope(
                onWillPop: () async{
                  Navigator.of(context).pop();
                  return await context.read<TaskProvider>().resetTaskReqData();
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isEditable =! isEditable;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(7.sp),
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(!isEditable ? Icons.edit : Icons.close)),
                        ),
                        SizedBox(width: 10.sp),
                        Container(
                            padding: EdgeInsets.all(7.sp),
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Icon(Icons.delete)),
                      ],
                    ),
                    CustomDropDownWidget(
                      selectedItem: createTaskReqModel.name,
                      name: "Project Name",
                      onTap: () {},
                    ),
                    SizedBox(height: 10.sp),

                    CustomTextField(
                      isEnable: (isEditable ? true : false),
                      name: "Title",
                      hint: "Title",
                      controller: titleController,
                      suffix: isEditable ? GestureDetector(
                          onTap: () async{
                            updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.Title;
                            updateTaskStatusPriorityUiState.fieldValue = createTaskReqModel.title;
                            await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
                          },
                          child: const Icon(Icons.save,color: kBlackColor)) : null,
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
                              onSelectedDateTime: (p0) async{
                                setState(() {
                                  createTaskReqModel.startDate = p0;
                                });
                                if(isEditable){
                                  updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.StartDate;
                                  updateTaskStatusPriorityUiState.fieldValue = DateFormat("yyyy-MM-dd").format(p0);
                                  await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
                                }
                              },
                              shoDatePicker: (isEditable ? false : true),
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
                              onSelectedDateTime: (p0) async{
                                setState(() {
                                  createTaskReqModel.endDate = p0;
                                });

                                if(isEditable){
                                  updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.EndDate;
                                  updateTaskStatusPriorityUiState.fieldValue = DateFormat("yyyy-MM-dd").format(p0);
                                  await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
                                }
                              },
                              shoDatePicker: (isEditable ? false : true),
                              radius: 5,
                              name: createTaskReqModel.endDate != null
                                  ? DateFormat("MM/dd/yyyy").format(createTaskReqModel.endDate!)
                                  : "End Date"),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.sp),

                    CustomDropDownWidget(
                      isUpdated: true,
                      // isUpdated: taskUpdateModel?.isUpdate,
                      isEditable: isEditable,
                      multiSelection: createTaskReqModel.multipleTestAssignUser,
                      name: "Assign to",
                      onTap: () async{
                        if(isEditable){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CustomSearchViewPage(
                                selectedItems: createTaskReqModel.multipleTestAssignUser,
                                onMultipleSelectedChange: (value) async{
                                  final taskProvider = context.read<TaskProvider>();
                                  createTaskReqModel.multipleTestAssignUser = [];
                                  for (var element in value) {
                                    var model = SaveUserDataInDetailsData(
                                        projectId: createTaskReqModel.projectID,
                                        userId: element.projectId,
                                        taskUserId: 0,
                                        name: element.name,
                                        taskId: createTaskReqModel.taskID
                                    );
                                    saveUserList.add(model);
                                    createTaskReqModel.multipleTestAssignUser?.add(element);
                                  }
                                  await taskProvider.saveUserInDetails(saveDataInDetailReqMode: SaveDataInDetailReqMode(saveUserList: saveUserList));
                                },
                                projectId: createTaskReqModel.projectID,
                                createTaskEnum: CreateTaskEnum.ASSIGN,
                                name: "Assign To",
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

                          if(isEditable){
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return CustomSearchViewPage(
                                createTaskEnum: CreateTaskEnum.STATUS,
                                name: "Status",
                                onChange: (value) async{
                                  createTaskReqModel.status = value.name;
                                  updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.Status;
                                  updateTaskStatusPriorityUiState.fieldValue = createTaskReqModel.status;
                                  await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
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

                        if(isEditable){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return CustomSearchViewPage(
                              createTaskEnum: CreateTaskEnum.PRIORITY,
                              name: "Priority",
                              onChange: (value) async{
                                createTaskReqModel.priority = value.name;
                                updateTaskStatusPriorityUiState.fieldName = TaskUpdateStatus.Priority;
                                updateTaskStatusPriorityUiState.fieldValue = createTaskReqModel.priority;
                                await context.read<TaskProvider>().updateTaskStatusAndPriorityData();
                                // setState(() {});
                              },
                            );
                          },));
                        }
                        },
                    ),

                    SizedBox(height: 10.sp,),
                    if(descriptionController.text.isNotEmpty)
                      CustomDescriptionField(
                        isEnable: false,
                        // isEnable: taskUpdateModel?.isUpdate == true ? false : true,
                        controller: descriptionController,
                        hint: "Details",
                        maxLine: 5,
                        onChanged: (value) {
                          setState(() {
                            createTaskReqModel.details = value;
                          });
                        },
                      ),
                    SizedBox(height: 10.sp),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: createTaskReqModel.userTaskSubPointList?.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
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
                      },
                    ),
                    SizedBox(height: 20.sp),

                  ],
                )
            )
        ),
      ),
    );
  }
}

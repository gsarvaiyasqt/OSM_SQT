import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/task_tab/domain/request/get_user_and_project_request_model.dart';
import 'package:osm_flutter/app/task_tab/domain/request/search_model.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
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

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {

  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  List<File>? mediaFileList = [];

 List<CreateSubPoint> createSubPoint = [];

 List<SearchModel> projectList = [];


 @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      final taskProvider = context.read<TaskProvider>();
     await taskProvider.getProjectAndAssignUser(getProjectAndAssignUserRequestModel: GetProjectAndAssignUserRequestModel());
      final projectList = taskProvider.getProjectAndUserResponse.data?.data?.projectList;
      if(projectList != null){

        for (var element in projectList) {

          this.projectList.add(SearchModel(name: element.projectName));

        }

      }


    });
  }

  @override
  Widget build(BuildContext context) {
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
                name: "Project Name",
                onTap: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return CustomSearchViewPage(
                          name: "Project Name",
                          list: projectList,
                        );
                      },
                    ));
                  });
                },
              ),
              SizedBox(height: 10.sp),
              CustomTextField(
                name: "Title",
                hint: "Title",
                controller: titleController,
              ),
              SizedBox(height: 10.sp),
          
              Row(
                children: [
                  Expanded(
                    child: CustomDatePickerWidget(
                        onSelectedDateTime: (p0) {
                          setState(() {
                            startDate = p0;
                          });
                        },
                        shoDatePicker: false,
                        radius: 5,
                        name: startDate != null
                            ? DateFormat("MM/dd/yyyy")
                                .format(startDate ?? DateTime.now())
                            : "Start Date"),
                  ),
                  SizedBox(width: 5.sp),
                  Expanded(
                    child: CustomDatePickerWidget(
                        onSelectedDateTime: (p0) {
                          setState(() {
                            endDate = p0;
                          });
                        },
                        shoDatePicker: false,
                        radius: 5,
                        name: endDate != null
                            ? DateFormat("MM/dd/yyyy")
                                .format(endDate ?? DateTime.now())
                            : "End Date"),
                  ),
                ],
              ),
          
              SizedBox(height: 10.sp),
          
              CustomDropDownWidget(
                name: "Assign to",
                onTap: () async{



                  setState(() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return CustomSearchViewPage(
                          name: "Project Name",
                          list: [],
                        );
                      },
                    ));
                  });
                },
              ),
          
              CustomDropDownWidget(
                name: "Status",
                onTap: () {
          
                },
              ),
          
              CustomDropDownWidget(
                name: "Priority",
                onTap: () {
          
                },
              ),

              SizedBox(height: 10.sp,),
              
              CustomDescriptionField(
                  controller: descriptionController,
                  hint: "Details",
                  maxLine: 5,
              ),



              SizedBox(height: 20.sp),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      btnText: "Add SubPoint",
                      btnColor: kSecondaryColor,
                      onTap: () {

                        var uuid = const Uuid();

                        setState(() {
                          createSubPoint.add(CreateSubPoint(uuid: uuid.v1()));
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
                itemCount: createSubPoint.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  createSubPoint[index].index = index;
                return Stack(
                  children: [
                    Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              createSubPoint.remove(createSubPoint[index]);
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
                    Padding(
                      padding:  EdgeInsets.all(10.sp),
                      child: CustomTextField(
                        hint: "Add SubPoint",
                        onChanged: (value) {
                          setState(() {

                            createSubPoint[index].text = value;

                          });
                        },
                      ),
                    )
                  ],
                );
              },),

              SizedBox(height: 20.sp),
              MultiSelectionImage(
                // apiImgList: imageList,
                imageFileList: mediaFileList,
                imageFileDataTap: (val){
                  setState(() {});
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
                      onTap: () {
                        Navigator.of(context).pop();
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

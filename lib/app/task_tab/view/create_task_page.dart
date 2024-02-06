import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/base/view/base_components/custom_text_form_filed.dart';
import 'package:osm_flutter/utils/common_utils/custom_details_textfield.dart';
import 'package:osm_flutter/utils/common_utils/custom_drop_down_widget.dart';
import 'package:osm_flutter/utils/common_utils/custom_serch_view_page.dart';
import 'package:osm_flutter/utils/utils.dart';

import '../../../base/view/base_components/multi_selection_images.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: kSecondaryBackgroundColor,
        title: Text("Create Task", style: CustomTextStyle.boldFont22Style),
      ),
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
                onTap: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return CustomSearchViewPage(
                          name: "Project Name",
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

              SizedBox(height: 50.sp,)

            ],
          ),
        ),
      ),
    );
  }
}

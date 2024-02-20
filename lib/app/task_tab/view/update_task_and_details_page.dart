import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osm_flutter/app/task_tab/view/comments_page.dart';
import 'package:osm_flutter/app/task_tab/view/file_page.dart';
import 'package:osm_flutter/app/task_tab/view/logs_page.dart';
import 'package:osm_flutter/app/task_tab/view/task_deatils.dart';
import 'package:osm_flutter/app/task_tab/view/task_detailes_page.dart';
import 'package:provider/provider.dart';
import '../../../utils/utils.dart';
import '../domain/request/save_user_in_deatils_req_model.dart';
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
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () async{
              final pop = Navigator.of(context);
              await context.read<TaskProvider>().resetTaskReqData();
              pop.pop();
            },
            child: const Icon(Icons.arrow_back,color: kBlackColor)),
        title: Text("Task Details Updates", style: CustomTextStyle.boldFont22Style),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          children: [
            Container(
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
                    onTap: () async{
                      final taskId = ModalRoute.of(context)?.settings.arguments as int;
                      final taskProvider = context.read<TaskProvider>();


                      setState(() {
                        selectedIndex = index;
                      });

                      switch(index){
                        case 0 :
                        await taskProvider.getTaskDetailsData(id: taskId);

                        case 1:
                        await taskProvider.getListTaskDetailsData(taskId: taskId,isLog: false);

                        case 3:
                        await taskProvider.getListTaskDetailsLogData(taskId: taskId, isLog: true);


                      }


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
              children: const [
                TaskDetailsPage(),
                CommentPage(),
                FilePage(),
                LogsPage()
              ],
            ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:osm_flutter/app/task_tab/components/custom_task_component.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/common_utils/custom_appbar.dart';
import '../../../utils/common_utils/custom_search_bar.dart';
import '../../../utils/utils.dart';
import '../../auth/domain/dummy/create_task_response.dart';
class TaskTabPage extends StatefulWidget {
  const TaskTabPage({Key? key}) : super(key: key);

  @override
  State<TaskTabPage> createState() => _TaskTabPageState();
}

class _TaskTabPageState extends State<TaskTabPage> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final listData = taskProvider.listData;



    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar:  CustomAppbar(
        height: 100.sp,
        lending: ImageUtil.dummy.profileImage,
        titleText: "Create setting Inner page design",
        action: Center(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.sp, vertical: 9.sp),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(Icons.pause, size: 20.sp),
              ),
              SizedBox(width: 10.sp),
              Text("01:34 hr",
                  style: CustomTextStyle.boldFont22Style
                      .copyWith(color: kBackgroundColor))
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        // padding: EdgeInsets.symmetric(left: 20.sp,right: 20.sp,top: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 20.sp,),

              CustomSearchBar(),
          
              SizedBox(height: 15.sp,),
          
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text("Tasks",
                          style: CustomTextStyle.boldFont24Style)),
                  GestureDetector(
                    onTap: () {
          
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                        color: kBlueColor,
                        borderRadius: BorderRadius.circular(100.sp),
                      ),
                      child: Icon(Icons.add, color: kWhiteColor, size: 24.sp),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 15.sp,),
          
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listData.length,
                itemBuilder: (context, index) {

                  final taskData = listData[index];

                  return CustomTaskComponent(
                    taskData: taskData,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

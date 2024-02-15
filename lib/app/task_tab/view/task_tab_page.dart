import 'package:flutter/material.dart';
import 'package:osm_flutter/app/task_tab/components/custom_task_component.dart';
import 'package:osm_flutter/app/task_tab/view_model/task_provider.dart';
import 'package:osm_flutter/utils/common_utils/skeleton_loading.dart';
import 'package:provider/provider.dart';

import '../../../utils/common_utils/custom_appbar.dart';
import '../../../utils/common_utils/custom_search_bar.dart';
import '../../../utils/utils.dart';
import '../../auth/domain/dummy/create_task_response.dart';
import '../domain/request/get_recent_task_request_model.dart';
import '../domain/request/get_status_count.dart';
class TaskTabPage extends StatefulWidget {
  const TaskTabPage({Key? key}) : super(key: key);

  @override
  State<TaskTabPage> createState() => _TaskTabPageState();
}

class _TaskTabPageState extends State<TaskTabPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final startDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day - 7,DateTime.now().hour,DateTime.now().minute,DateTime.now().second);
      final endDate = DateTime(DateTime.now().year - 3,DateTime.now().month,DateTime.now().day,DateTime.now().hour,DateTime.now().minute,DateTime.now().second);

      final taskProvider = context.read<TaskProvider>();

      await taskProvider.getRecentTaskListData(recentTaskRequestModel: RecentTaskRequestModel(
      ));

    });
  }


  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final taskLoader = taskProvider.resentTaskResponse.state == Status.LOADING;
    final listData = taskProvider.listData;
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
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
                          style: CustomTextStyle.boldFont24Style)
                  ),
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
                itemCount: taskLoader ? 10 : listData.length,
                reverse: true,
                itemBuilder: (context, index) {

                  if(taskLoader){
                    return  taskCardSimmer(recentLoader: taskLoader);
                  }

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

  Widget taskCardSimmer({bool? recentLoader}){
    return Card(
      color: Colors.white,
      shadowColor: kSkyBlueColor.withOpacity(0.5),
      child: Container(
        padding: EdgeInsets.all(12.sp),
        child: Row(
          children: [
            SkeletonView(
              isLoading: recentLoader,
              borderRadius: BorderRadius.circular(100),
              skeletonBody: SizedBox(
                height: 40.sp,
                width: 40.sp,
              ),
            ),

            SizedBox(width: 10.sp),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonView(
                    isLoading: recentLoader,
                    borderRadius: BorderRadius.circular(8.sp),
                    child: SizedBox(
                      height: 14.sp,
                      width: 60.sp,
                    ),
                  ),

                  SizedBox(height: 5.sp),

                  SkeletonView(
                    isLoading: recentLoader,
                    borderRadius: BorderRadius.circular(8.sp),
                    child:SizedBox(
                      height: 16.sp,
                      width: 90.sp,
                    ),
                  ),
                ],
              ),
            ),

            SkeletonView(
              isLoading: recentLoader,
              borderRadius: BorderRadius.circular(5.sp),
              skeletonBody: SizedBox(
                height: 16.sp,
                width: 16.sp,
              ),
            ),

            SizedBox(
              width: 10.sp,
            ),

            // Time Working
            SkeletonView(
              isLoading: recentLoader,
              borderRadius: BorderRadius.circular(5.sp),
              skeletonBody: SizedBox(
                height: 14.sp,
                width: 70.sp,
              ),
            ),

            SizedBox(width: 10.sp),

            SkeletonView(
              isLoading: recentLoader,
              borderRadius: BorderRadius.circular(8.sp),
              skeletonBody: SizedBox(
                height: 24.sp,
                width: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
